import Foundation
import IntentFlow

@MainActor
final class DemoStoreModel<Reducer: FlowReducer, Effects: FlowEffectHandler, ViewState: Equatable & Sendable>: ObservableObject
where Reducer.Effect == Effects.Effect, Reducer.Event == Effects.Event {
    typealias Projection = @Sendable (Reducer.State) -> ViewState

    @Published private(set) var viewState: ViewState

    private let store: FlowStore<Reducer, Effects>
    private let project: Projection
    private var observation: FlowObservation?
    private var bindTask: Task<Void, Never>?

    init(
        initialState: Reducer.State,
        reducer: Reducer,
        effects: Effects,
        project: @escaping Projection
    ) {
        self.store = FlowStore(initialState: initialState, reducer: reducer, effects: effects)
        self.project = project
        self.viewState = project(initialState)
    }

    deinit {
        observation?.cancel()
        bindTask?.cancel()
    }

    func bind() {
        guard observation == nil else {
            return
        }

        bindTask = Task { [weak self] in
            guard let self else {
                return
            }

            let observation = await store.observe { [weak self] snapshot in
                Task { @MainActor [weak self] in
                    guard let self else {
                        return
                    }
                    self.viewState = self.project(snapshot.state)
                }
            }

            self.observation = observation
        }
    }

    func send(_ intent: Reducer.Intent) {
        Task { [weak store] in
            await store?.send(intent)
        }
    }
}
