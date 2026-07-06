import Foundation
import SwiftUI
import IntentFlow

enum CheckoutState: Equatable, Sendable {
    case idle
    case validatingCart
    case authorizingPayment
    case failed(String)
    case completed(orderID: String)
}

enum CheckoutIntent: Equatable, Sendable {
    case pay
    case retry
    case cancel
}

enum CheckoutEvent: Equatable, Sendable {
    case cartValid
    case paymentAuthorized(orderID: String)
    case failed(String)
}

enum CheckoutEffect: Equatable, Sendable {
    case validateCart
    case authorizePayment
}

enum CheckoutOutput: Equatable, Sendable {
    case orderCompleted(String)
    case cancelled
}

enum CheckoutRoute: Equatable, Sendable {
    case paymentSheet
}

struct CheckoutFlow: FlowReducer {
    func reduce(
        state: CheckoutState,
        signal: FlowSignal<CheckoutIntent, CheckoutEvent>
    ) -> Next<CheckoutState, CheckoutEffect, CheckoutOutput, CheckoutRoute> {
        switch (state, signal) {
        case (.idle, .intent(.pay)),
             (.failed, .intent(.retry)):
            return .state(.validatingCart)
                .effect(.validateCart, id: "checkout.cart", policy: .cancelInFlight)

        case (.validatingCart, .event(.cartValid)):
            return .state(.authorizingPayment)
                .route(.paymentSheet)
                .effect(.authorizePayment, id: "checkout.payment", policy: .cancelInFlight)

        case (.authorizingPayment, .event(.paymentAuthorized(let orderID))):
            return .state(.completed(orderID: orderID))
                .output(.orderCompleted(orderID))

        case (_, .event(.failed(let message))):
            return .state(.failed(message))

        case (_, .intent(.cancel)):
            return .state(.idle)
                .cancel("checkout.cart")
                .cancel("checkout.payment")
                .output(.cancelled)

        default:
            return .state(state)
        }
    }
}

struct CheckoutEffects: FlowEffectHandler {
    func handle(_ effect: CheckoutEffect) -> AsyncStream<CheckoutEvent> {
        AsyncStream { continuation in
            let task = Task {
                try? await Task.sleep(for: .milliseconds(250))
                switch effect {
                case .validateCart:
                    continuation.yield(.cartValid)
                case .authorizePayment:
                    continuation.yield(.paymentAuthorized(orderID: "order-1001"))
                }
                continuation.finish()
            }
            continuation.onTermination = { _ in task.cancel() }
        }
    }
}

struct CheckoutViewState: Equatable, Sendable {
    let title: String
    let detail: String
    let isBusy: Bool
    let buttonTitle: String
}

struct CheckoutProjection {
    func project(_ state: CheckoutState) -> CheckoutViewState {
        switch state {
        case .idle:
            return .init(title: "Checkout", detail: "Ready to pay", isBusy: false, buttonTitle: "Pay")
        case .validatingCart:
            return .init(title: "Validating", detail: "Checking cart", isBusy: true, buttonTitle: "Pay")
        case .authorizingPayment:
            return .init(title: "Authorizing", detail: "Payment in progress", isBusy: true, buttonTitle: "Pay")
        case .failed(let message):
            return .init(title: "Payment Failed", detail: message, isBusy: false, buttonTitle: "Retry")
        case .completed(let orderID):
            return .init(title: "Complete", detail: orderID, isBusy: false, buttonTitle: "Pay Again")
        }
    }
}

struct CheckoutDemoScreen: View {
    @StateObject private var model = DemoStoreModel(
        initialState: CheckoutState.idle,
        reducer: CheckoutFlow(),
        effects: CheckoutEffects(),
        project: CheckoutProjection().project
    )

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text(model.viewState.detail)
                    .font(.headline)

                if model.viewState.isBusy {
                    ProgressView()
                }

                Button(model.viewState.buttonTitle) {
                    model.send(.pay)
                }
                .buttonStyle(.borderedProminent)
                .disabled(model.viewState.isBusy)

                Button("Cancel") {
                    model.send(.cancel)
                }
                .disabled(model.viewState.isBusy == false)
            }
            .padding()
            .navigationTitle(model.viewState.title)
            .onAppear { model.bind() }
        }
    }
}
