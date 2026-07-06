import IntentFlow

enum LoginState: Equatable, Sendable {
    case idle
    case validating(String)
    case requestingToken
    case waitingForTwoFactor
    case failed(String)
    case authenticated(String)
}

enum LoginIntent: Equatable, Sendable {
    case submit(email: String, password: String)
    case submitTwoFactor(String)
    case retry
    case cancel
}

enum LoginEvent: Equatable, Sendable {
    case credentialsValid
    case credentialsInvalid(String)
    case tokenRequiresTwoFactor
    case tokenReceived(String)
    case tokenFailed(String)
}

enum LoginEffect: Equatable, Sendable {
    case validate(email: String, password: String)
    case requestToken
    case verifyTwoFactor(String)
}

enum LoginOutput: Equatable, Sendable {
    case completed(userID: String)
}

enum LoginRoute: Equatable, Sendable {
    case twoFactor
}

struct LoginFlow: FlowReducer {
    func reduce(
        state: LoginState,
        signal: FlowSignal<LoginIntent, LoginEvent>
    ) -> Next<LoginState, LoginEffect, LoginOutput, LoginRoute> {
        switch (state, signal) {
        case (.idle, .intent(.submit(let email, let password))),
             (.failed, .intent(.submit(let email, let password))):
            return .state(.validating(email))
                .effect(
                    .validate(email: email, password: password),
                    id: "login.validate",
                    policy: .cancelInFlight
                )

        case (.validating, .event(.credentialsValid)):
            return .state(.requestingToken)
                .effect(.requestToken, id: "login.token", policy: .cancelInFlight)

        case (.validating, .event(.credentialsInvalid(let message))):
            return .state(.failed(message))

        case (.requestingToken, .event(.tokenRequiresTwoFactor)):
            return .state(.waitingForTwoFactor)
                .route(.twoFactor)

        case (.waitingForTwoFactor, .intent(.submitTwoFactor(let code))):
            return .state(.requestingToken)
                .effect(.verifyTwoFactor(code), id: "login.2fa", policy: .cancelInFlight)

        case (.requestingToken, .event(.tokenReceived(let userID))):
            return .state(.authenticated(userID))
                .output(.completed(userID: userID))

        case (.requestingToken, .event(.tokenFailed(let message))):
            return .state(.failed(message))

        case (_, .intent(.cancel)):
            return .state(.idle)
                .cancel("login.validate")
                .cancel("login.token")
                .cancel("login.2fa")

        default:
            return .state(state)
        }
    }
}

struct LoginEffects: FlowEffectHandler {
    func handle(_ effect: LoginEffect) -> AsyncStream<LoginEvent> {
        AsyncStream { continuation in
            Task {
                switch effect {
                case .validate:
                    continuation.yield(.credentialsValid)
                case .requestToken:
                    continuation.yield(.tokenReceived("user-1"))
                case .verifyTwoFactor:
                    continuation.yield(.tokenReceived("user-1"))
                }
                continuation.finish()
            }
        }
    }
}
