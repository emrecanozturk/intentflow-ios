public protocol FlowReducer: Sendable {
    associatedtype State: Equatable & Sendable
    associatedtype Intent: Sendable
    associatedtype Event: Sendable
    associatedtype Effect: Sendable
    associatedtype Output: Sendable
    associatedtype Route: Sendable

    func reduce(
        state: State,
        signal: FlowSignal<Intent, Event>
    ) -> Next<State, Effect, Output, Route>
}
