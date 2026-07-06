public struct Next<State: Sendable, Effect: Sendable, Output: Sendable, Route: Sendable>: Sendable {
    public let state: State
    public let effects: [EffectRequest<Effect>]
    public let outputs: [Output]
    public let routes: [Route]

    public init(
        state: State,
        effects: [EffectRequest<Effect>] = [],
        outputs: [Output] = [],
        routes: [Route] = []
    ) {
        self.state = state
        self.effects = effects
        self.outputs = outputs
        self.routes = routes
    }

    public static func state(_ state: State) -> Self {
        Self(state: state)
    }

    public func effect(
        _ effect: Effect,
        id: EffectID? = nil,
        policy: EffectPolicy = .run
    ) -> Self {
        Self(
            state: state,
            effects: effects + [.run(effect, id: id, policy: policy)],
            outputs: outputs,
            routes: routes
        )
    }

    public func cancel(_ id: EffectID) -> Self {
        Self(
            state: state,
            effects: effects + [.cancel(id)],
            outputs: outputs,
            routes: routes
        )
    }

    public func output(_ output: Output) -> Self {
        Self(
            state: state,
            effects: effects,
            outputs: outputs + [output],
            routes: routes
        )
    }

    public func route(_ route: Route) -> Self {
        Self(
            state: state,
            effects: effects,
            outputs: outputs,
            routes: routes + [route]
        )
    }
}

extension Next: Equatable where State: Equatable, Effect: Equatable, Output: Equatable, Route: Equatable {}
