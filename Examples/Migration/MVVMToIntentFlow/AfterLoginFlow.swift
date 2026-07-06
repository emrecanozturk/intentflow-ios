import IntentFlow

struct AfterLoginFlow: FlowReducer {
    func reduce(
        state: AfterLoginState,
        signal: FlowSignal<AfterLoginIntent, AfterLoginEvent>
    ) -> Next<AfterLoginState, AfterLoginEffect, AfterLoginOutput, AfterLoginRoute> {
        switch (state, signal) {
        case (.idle, .intent(.submit(let email, let password))),
             (.failed, .intent(.submit(let email, let password))):
            return .state(.validating(email: email, password: password))
                .effect(.validate(email: email, password: password), id: "login.validate", policy: .cancelInFlight)

        case (.validating, .event(.inputValid)):
            return .state(.requestingToken)
                .effect(.requestToken, id: "login.token", policy: .cancelInFlight)

        case (.validating, .event(.inputInvalid(let message))),
             (.requestingToken, .event(.failed(let message))):
            return .state(.failed(message))

        case (.requestingToken, .event(.twoFactorRequired)):
            return .state(.waitingForTwoFactor)
                .route(.twoFactor)

        case (.waitingForTwoFactor, .intent(.submitTwoFactor(let code))):
            return .state(.requestingToken)
                .effect(.verifyTwoFactor(code), id: "login.2fa", policy: .cancelInFlight)

        case (.requestingToken, .event(.tokenReceived(let userID))):
            return .state(.authenticated(userID))
                .output(.completed(userID))

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
