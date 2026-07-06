public enum EffectPolicy: Equatable, Sendable {
    case run
    case cancelInFlight
    case cancelOnly
}
