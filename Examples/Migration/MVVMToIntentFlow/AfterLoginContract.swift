import IntentFlow

enum AfterLoginState: Equatable, Sendable {
    case idle
    case validating(email: String, password: String)
    case requestingToken
    case waitingForTwoFactor
    case failed(String)
    case authenticated(String)
}

enum AfterLoginIntent: Equatable, Sendable {
    case submit(email: String, password: String)
    case submitTwoFactor(String)
    case cancel
}

enum AfterLoginEvent: Equatable, Sendable {
    case inputValid
    case inputInvalid(String)
    case tokenReceived(String)
    case twoFactorRequired
    case failed(String)
}

enum AfterLoginEffect: Equatable, Sendable {
    case validate(email: String, password: String)
    case requestToken
    case verifyTwoFactor(String)
}

enum AfterLoginOutput: Equatable, Sendable {
    case completed(String)
}

enum AfterLoginRoute: Equatable, Sendable {
    case twoFactor
}
