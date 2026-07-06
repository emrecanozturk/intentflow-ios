public protocol FlowEffectHandler: Sendable {
    associatedtype Effect: Sendable
    associatedtype Event: Sendable

    func handle(_ effect: Effect) -> AsyncStream<Event>
}

public struct NoEffectHandler<Effect: Sendable, Event: Sendable>: FlowEffectHandler {
    public init() {}

    public func handle(_ effect: Effect) -> AsyncStream<Event> {
        AsyncStream { continuation in
            continuation.finish()
        }
    }
}
