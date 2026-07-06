public protocol FlowProjection: Sendable {
    associatedtype State: Sendable
    associatedtype ViewState: Equatable & Sendable

    func project(_ state: State) -> ViewState
}
