public enum FlowSignal<Intent: Sendable, Event: Sendable>: Sendable {
    case intent(Intent)
    case event(Event)
}

extension FlowSignal: Equatable where Intent: Equatable, Event: Equatable {}
