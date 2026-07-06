import Foundation

public actor FlowStore<Reducer: FlowReducer, Effects: FlowEffectHandler>
where Reducer.Effect == Effects.Effect, Reducer.Event == Effects.Event {
    public typealias State = Reducer.State
    public typealias Intent = Reducer.Intent
    public typealias Event = Reducer.Event
    public typealias Output = Reducer.Output
    public typealias Route = Reducer.Route

    private let reducer: Reducer
    private let effects: Effects
    private var currentState: State
    private var runningEffects: [EffectID: Task<Void, Never>] = [:]
    private var snapshots: [FlowSnapshot<State, Output, Route>] = []
    private var observers: [UUID: @Sendable (FlowSnapshot<State, Output, Route>) -> Void] = [:]

    public init(
        initialState: State,
        reducer: Reducer,
        effects: Effects
    ) {
        self.currentState = initialState
        self.reducer = reducer
        self.effects = effects
    }

    deinit {
        for task in runningEffects.values {
            task.cancel()
        }
    }

    public var state: State {
        currentState
    }

    public var history: [FlowSnapshot<State, Output, Route>] {
        snapshots
    }

    @discardableResult
    public func send(_ intent: Intent) -> FlowSnapshot<State, Output, Route> {
        apply(.intent(intent))
    }

    @discardableResult
    public func receive(_ event: Event) -> FlowSnapshot<State, Output, Route> {
        apply(.event(event))
    }

    public func cancelEffect(id: EffectID) {
        runningEffects[id]?.cancel()
        runningEffects[id] = nil
    }

    public func cancelAllEffects() {
        for task in runningEffects.values {
            task.cancel()
        }
        runningEffects.removeAll()
    }

    public func observe(
        _ observer: @escaping @Sendable (FlowSnapshot<State, Output, Route>) -> Void
    ) -> FlowObservation {
        let id = UUID()
        observers[id] = observer

        return FlowObservation { [weak self] in
            Task {
                await self?.removeObserver(id: id)
            }
        }
    }

    private func apply(_ signal: FlowSignal<Intent, Event>) -> FlowSnapshot<State, Output, Route> {
        let next = reducer.reduce(state: currentState, signal: signal)
        currentState = next.state

        let snapshot = FlowSnapshot(
            state: next.state,
            outputs: next.outputs,
            routes: next.routes
        )
        snapshots.append(snapshot)
        publish(snapshot)

        for request in next.effects {
            process(request)
        }

        return snapshot
    }

    private func process(_ request: EffectRequest<Reducer.Effect>) {
        if let id = request.id, request.policy == .cancelOnly {
            cancelEffect(id: id)
            return
        }

        if let id = request.id, request.policy == .cancelInFlight {
            cancelEffect(id: id)
        }

        guard let effect = request.effect else {
            return
        }

        let id = request.id
        let effects = self.effects
        let task = Task { [weak self, effects, effect, id] in
            for await event in effects.handle(effect) {
                if Task.isCancelled {
                    break
                }
                _ = await self?.receive(event)
            }

            if let id {
                await self?.finishEffect(id: id)
            }
        }

        if let id {
            runningEffects[id] = task
        }
    }

    private func finishEffect(id: EffectID) {
        if runningEffects[id]?.isCancelled == false {
            runningEffects[id] = nil
        } else {
            runningEffects[id] = nil
        }
    }

    private func publish(_ snapshot: FlowSnapshot<State, Output, Route>) {
        for observer in observers.values {
            observer(snapshot)
        }
    }

    private func removeObserver(id: UUID) {
        observers[id] = nil
    }
}
