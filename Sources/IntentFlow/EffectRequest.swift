public struct EffectRequest<Effect: Sendable>: Sendable {
    public let id: EffectID?
    public let policy: EffectPolicy
    public let effect: Effect?

    public init(
        id: EffectID? = nil,
        policy: EffectPolicy = .run,
        effect: Effect?
    ) {
        self.id = id
        self.policy = policy
        self.effect = effect
    }

    public static func run(
        _ effect: Effect,
        id: EffectID? = nil,
        policy: EffectPolicy = .run
    ) -> Self {
        Self(id: id, policy: policy, effect: effect)
    }

    public static func cancel(_ id: EffectID) -> Self {
        Self(id: id, policy: .cancelOnly, effect: nil)
    }
}

extension EffectRequest: Equatable where Effect: Equatable {}
