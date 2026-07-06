public struct FlowSnapshot<State: Sendable, Output: Sendable, Route: Sendable>: Sendable {
    public let state: State
    public let outputs: [Output]
    public let routes: [Route]

    public init(
        state: State,
        outputs: [Output],
        routes: [Route]
    ) {
        self.state = state
        self.outputs = outputs
        self.routes = routes
    }
}

extension FlowSnapshot: Equatable where State: Equatable, Output: Equatable, Route: Equatable {}
