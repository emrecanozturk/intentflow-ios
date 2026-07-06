import XCTest
import IntentFlow

final class FlowReducerTests: XCTestCase {
    func testPureTraceKeepsBehaviorVisibleWithoutUI() {
        let trace = LoginFlow().trace(
            initialState: .idle,
            signals: [
                .intent(.submit(email: "emre@example.com", password: "secret")),
                .event(.credentialsValid),
                .event(.tokenRequiresTwoFactor)
            ]
        )

        XCTAssertEqual(trace.steps.map(\.state), [
            .validating("emre@example.com"),
            .requestingToken,
            .waitingForTwoFactor
        ])

        XCTAssertEqual(trace.steps[2].routes, [.twoFactor])
    }

    func testCancelIntentCancelsAllKnownLoginEffects() {
        let next = LoginFlow().reduce(
            state: .requestingToken,
            signal: .intent(.cancel)
        )

        XCTAssertEqual(next.state, .idle)
        XCTAssertEqual(next.effects, [
            .cancel("login.validate"),
            .cancel("login.token"),
            .cancel("login.2fa")
        ])
    }
}
