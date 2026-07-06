import SwiftUI
import IntentFlow

enum PermissionState: Equatable, Sendable {
    case unknown
    case requesting
    case granted
    case denied
}

enum PermissionIntent: Equatable, Sendable {
    case request
    case openSettings
}

enum PermissionEvent: Equatable, Sendable {
    case resolved(Bool)
}

enum PermissionEffect: Equatable, Sendable {
    case requestCamera
}

enum PermissionOutput: Equatable, Sendable {
    case available
}

enum PermissionRoute: Equatable, Sendable {
    case settings
}

struct PermissionFlow: FlowReducer {
    func reduce(
        state: PermissionState,
        signal: FlowSignal<PermissionIntent, PermissionEvent>
    ) -> Next<PermissionState, PermissionEffect, PermissionOutput, PermissionRoute> {
        switch (state, signal) {
        case (.unknown, .intent(.request)),
             (.denied, .intent(.request)):
            return .state(.requesting)
                .effect(.requestCamera, id: "permission.camera", policy: .cancelInFlight)

        case (.requesting, .event(.resolved(true))):
            return .state(.granted)
                .output(.available)

        case (.requesting, .event(.resolved(false))):
            return .state(.denied)

        case (.denied, .intent(.openSettings)):
            return .state(.denied)
                .route(.settings)

        default:
            return .state(state)
        }
    }
}

struct PermissionEffects: FlowEffectHandler {
    func handle(_ effect: PermissionEffect) -> AsyncStream<PermissionEvent> {
        AsyncStream { continuation in
            let task = Task {
                try? await Task.sleep(for: .milliseconds(200))
                continuation.yield(.resolved(false))
                continuation.finish()
            }
            continuation.onTermination = { _ in task.cancel() }
        }
    }
}

struct PermissionProjection {
    func project(_ state: PermissionState) -> PermissionViewState {
        switch state {
        case .unknown:
            return .init(title: "Camera Permission", detail: "Permission has not been requested.", buttonTitle: "Request", isBusy: false)
        case .requesting:
            return .init(title: "Requesting", detail: "Waiting for the system.", buttonTitle: "Request", isBusy: true)
        case .granted:
            return .init(title: "Granted", detail: "The feature is available.", buttonTitle: "Request", isBusy: false)
        case .denied:
            return .init(title: "Denied", detail: "Open Settings to enable access.", buttonTitle: "Open Settings", isBusy: false)
        }
    }
}

struct PermissionViewState: Equatable, Sendable {
    let title: String
    let detail: String
    let buttonTitle: String
    let isBusy: Bool
}

struct PermissionDemoScreen: View {
    @StateObject private var model = DemoStoreModel(
        initialState: PermissionState.unknown,
        reducer: PermissionFlow(),
        effects: PermissionEffects(),
        project: PermissionProjection().project
    )

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text(model.viewState.detail)

                if model.viewState.isBusy {
                    ProgressView()
                }

                Button(model.viewState.buttonTitle) {
                    if model.viewState.buttonTitle == "Open Settings" {
                        model.send(.openSettings)
                    } else {
                        model.send(.request)
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationTitle(model.viewState.title)
            .onAppear { model.bind() }
        }
    }
}
