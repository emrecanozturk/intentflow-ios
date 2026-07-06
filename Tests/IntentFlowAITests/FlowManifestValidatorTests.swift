import XCTest
import IntentFlowAI

final class FlowManifestValidatorTests: XCTestCase {
    func testAIModeRequiresInvariantsAndAcceptanceTraces() {
        let manifest = FlowManifest(
            feature: "Checkout",
            mode: .ai,
            summary: "Checkout flow",
            states: ["idle"],
            intents: ["pay"],
            events: [],
            effects: [],
            routes: [],
            outputs: [],
            invariants: [],
            acceptanceTraces: []
        )

        let issues = FlowManifestValidator().validate(manifest)

        XCTAssertTrue(issues.contains(.init(severity: .error, message: "AI mode requires explicit invariants")))
        XCTAssertTrue(issues.contains(.init(severity: .error, message: "AI mode requires acceptance traces")))
    }

    func testPlanAddsAIFilesOnlyForAIMode() {
        let manifest = FlowManifest(
            feature: "Login",
            mode: .ai,
            summary: "Login flow",
            states: ["idle", "loading", "failed"],
            intents: ["submit"],
            events: ["loaded"],
            effects: ["load"],
            routes: [],
            outputs: [],
            invariants: ["No token is stored before authentication succeeds."],
            acceptanceTraces: ["idle + submit -> loading"]
        )

        let plan = FlowManifestValidator().makePlan(for: manifest)

        XCTAssertEqual(plan.mode, .ai)
        XCTAssertTrue(plan.requiredFiles.contains("Login.intentflow.yaml"))
        XCTAssertTrue(plan.requiredFiles.contains("LoginPrompts.md"))
    }
}
