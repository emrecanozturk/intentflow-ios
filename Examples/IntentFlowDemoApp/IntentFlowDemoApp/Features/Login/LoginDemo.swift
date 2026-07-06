import Foundation
import SwiftUI
import IntentFlow

enum LoginDemoState: Equatable, Sendable {
    case idle
    case validating(email: String)
    case authenticated(userID: String)
    case failed(message: String)
}

enum LoginDemoIntent: Equatable, Sendable {
    case submit(email: String, password: String)
    case retry
}

enum LoginDemoEvent: Equatable, Sendable {
    case valid(userID: String)
    case invalid(String)
}

enum LoginDemoEffect: Equatable, Sendable {
    case authenticate(email: String, password: String)
}

enum LoginDemoOutput: Equatable, Sendable {
    case completed(userID: String)
}

enum LoginDemoRoute: Equatable, Sendable {
    case none
}

struct LoginDemoFlow: FlowReducer {
    func reduce(
        state: LoginDemoState,
        signal: FlowSignal<LoginDemoIntent, LoginDemoEvent>
    ) -> Next<LoginDemoState, LoginDemoEffect, LoginDemoOutput, LoginDemoRoute> {
        switch (state, signal) {
        case (.idle, .intent(.submit(let email, let password))),
             (.failed, .intent(.submit(let email, let password))):
            return .state(.validating(email: email))
                .effect(.authenticate(email: email, password: password), id: "demo.login", policy: .cancelInFlight)

        case (.validating, .event(.valid(let userID))):
            return .state(.authenticated(userID: userID))
                .output(.completed(userID: userID))

        case (.validating, .event(.invalid(let message))):
            return .state(.failed(message: message))

        case (.failed, .intent(.retry)):
            return .state(.idle)

        default:
            return .state(state)
        }
    }
}

struct LoginDemoEffects: FlowEffectHandler {
    func handle(_ effect: LoginDemoEffect) -> AsyncStream<LoginDemoEvent> {
        AsyncStream { continuation in
            let task = Task {
                switch effect {
                case .authenticate(let email, let password):
                    try? await Task.sleep(for: .milliseconds(300))
                    if email.contains("@"), password.count >= 4 {
                        continuation.yield(.valid(userID: "demo-user"))
                    } else {
                        continuation.yield(.invalid("Use an email and a four character password."))
                    }
                }
                continuation.finish()
            }
            continuation.onTermination = { _ in task.cancel() }
        }
    }
}

struct LoginDemoViewState: Equatable, Sendable {
    let title: String
    let buttonTitle: String
    let isBusy: Bool
    let message: String?
}

struct LoginDemoProjection {
    func project(_ state: LoginDemoState) -> LoginDemoViewState {
        switch state {
        case .idle:
            return .init(title: "Login", buttonTitle: "Submit", isBusy: false, message: nil)
        case .validating(let email):
            return .init(title: "Validating", buttonTitle: "Submit", isBusy: true, message: email)
        case .authenticated(let userID):
            return .init(title: "Authenticated", buttonTitle: "Submit Again", isBusy: false, message: userID)
        case .failed(let message):
            return .init(title: "Try Again", buttonTitle: "Retry", isBusy: false, message: message)
        }
    }
}

struct LoginDemoScreen: View {
    @StateObject private var model = DemoStoreModel(
        initialState: LoginDemoState.idle,
        reducer: LoginDemoFlow(),
        effects: LoginDemoEffects(),
        project: LoginDemoProjection().project
    )
    @State private var email = "emre@example.com"
    @State private var password = "pass"

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Email", text: $email)
                        .textInputAutocapitalization(.never)
                    SecureField("Password", text: $password)
                }

                Section {
                    Button(model.viewState.buttonTitle) {
                        model.send(.submit(email: email, password: password))
                    }
                    .disabled(model.viewState.isBusy)

                    if model.viewState.isBusy {
                        ProgressView()
                    }

                    if let message = model.viewState.message {
                        Text(message)
                    }
                }
            }
            .navigationTitle(model.viewState.title)
            .onAppear { model.bind() }
        }
    }
}
