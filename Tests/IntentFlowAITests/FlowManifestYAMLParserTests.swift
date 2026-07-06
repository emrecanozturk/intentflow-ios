import XCTest
import IntentFlowAI

final class FlowManifestYAMLParserTests: XCTestCase {
    func testParsesManifest() throws {
        let source = """
        schemaVersion: "0.1"
        feature: "Login"
        mode: "ai"
        summary: "Authenticate"
        states:
          - idle
          - loading
          - failed(message)
        intents:
          - submit
        events:
          - loaded
        effects:
          - load
        routes:
          - twoFactor
        outputs:
          - completed
        invariants:
          - "Token is persisted only after success."
        acceptanceTraces:
          - "idle + submit -> loading"
        """

        let manifest = try FlowManifestYAMLParser().parse(source)

        XCTAssertEqual(manifest.feature, "Login")
        XCTAssertEqual(manifest.mode, .ai)
        XCTAssertEqual(manifest.states, ["idle", "loading", "failed(message)"])
        XCTAssertEqual(manifest.invariants, ["Token is persisted only after success."])
    }
}
