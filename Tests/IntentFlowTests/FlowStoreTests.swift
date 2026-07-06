import XCTest
import IntentFlow

final class FlowStoreTests: XCTestCase {
    func testStoreRunsEffectsBackIntoEvents() async throws {
        let store = FlowStore(
            initialState: LoginState.idle,
            reducer: LoginFlow(),
            effects: LoginEffects()
        )

        await store.send(.submit(email: "emre@example.com", password: "secret"))

        try await Task.sleep(for: .milliseconds(80))

        let state = await store.state
        XCTAssertEqual(state, .authenticated("user-1"))
    }

    func testHistoryRecordsStateOutputsAndRoutes() async {
        let store = FlowStore(
            initialState: LoginState.requestingToken,
            reducer: LoginFlow(),
            effects: LoginEffects()
        )

        await store.receive(.tokenRequiresTwoFactor)

        let history = await store.history
        XCTAssertEqual(history, [
            .init(state: .waitingForTwoFactor, outputs: [], routes: [.twoFactor])
        ])
    }

    func testObservationReceivesSnapshots() async throws {
        let store = FlowStore(
            initialState: LoginState.requestingToken,
            reducer: LoginFlow(),
            effects: LoginEffects()
        )
        let box = SnapshotBox<LoginState, LoginOutput, LoginRoute>()

        let observation = await store.observe { snapshot in
            Task {
                await box.append(snapshot)
            }
        }

        await store.receive(.tokenRequiresTwoFactor)
        try await Task.sleep(for: .milliseconds(20))
        observation.cancel()

        let values = await box.values
        XCTAssertEqual(values, [
            .init(state: .waitingForTwoFactor, outputs: [], routes: [.twoFactor])
        ])
    }
}

private actor SnapshotBox<State: Sendable, Output: Sendable, Route: Sendable> {
    private var snapshots: [FlowSnapshot<State, Output, Route>] = []

    var values: [FlowSnapshot<State, Output, Route>] {
        snapshots
    }

    func append(_ snapshot: FlowSnapshot<State, Output, Route>) {
        snapshots.append(snapshot)
    }
}
