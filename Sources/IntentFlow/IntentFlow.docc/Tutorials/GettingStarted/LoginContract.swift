import IntentFlow

enum LoginState: Equatable, Sendable {
    case idle
    case loading
    case failed(String)
    case authenticated(String)
}

enum LoginIntent: Equatable, Sendable {
    case submit(email: String, password: String)
}

enum LoginEvent: Equatable, Sendable {
    case authenticated(String)
    case failed(String)
}

enum LoginEffect: Equatable, Sendable {
    case authenticate(email: String, password: String)
}

enum LoginOutput: Equatable, Sendable {
    case completed(String)
}

enum LoginRoute: Equatable, Sendable {
    case twoFactor
}
