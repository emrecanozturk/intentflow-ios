public struct FlowTraceStep<State: Sendable, Effect: Sendable, Output: Sendable, Route: Sendable>: Sendable {
    public let state: State
    public let effects: [EffectRequest<Effect>]
    public let outputs: [Output]
    public let routes: [Route]

    public init(_ next: Next<State, Effect, Output, Route>) {
        self.state = next.state
        self.effects = next.effects
        self.outputs = next.outputs
        self.routes = next.routes
    }
}

extension FlowTraceStep: Equatable where State: Equatable, Effect: Equatable, Output: Equatable, Route: Equatable {}

public struct FlowTrace<Reducer: FlowReducer>: Sendable {
    public let steps: [FlowTraceStep<Reducer.State, Reducer.Effect, Reducer.Output, Reducer.Route>]

    public init(steps: [FlowTraceStep<Reducer.State, Reducer.Effect, Reducer.Output, Reducer.Route>]) {
        self.steps = steps
    }
}

extension FlowReducer {
    public func trace(
        initialState: State,
        signals: [FlowSignal<Intent, Event>]
    ) -> FlowTrace<Self> {
        var state = initialState
        var steps: [FlowTraceStep<State, Effect, Output, Route>] = []

        for signal in signals {
            let next = reduce(state: state, signal: signal)
            state = next.state
            steps.append(FlowTraceStep(next))
        }

        return FlowTrace(steps: steps)
    }
}
