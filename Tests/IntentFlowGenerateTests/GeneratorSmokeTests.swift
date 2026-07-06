import XCTest
import IntentFlowAI
@testable import IntentFlowGenerate

final class GeneratorSmokeTests: XCTestCase {
    func testGeneratorWritesCoreFeature() throws {
        let directory = URL(fileURLWithPath: NSTemporaryDirectory())
            .appendingPathComponent(UUID().uuidString, isDirectory: true)

        try IntentFlowGenerate.generate(
            name: "Profile",
            mode: .core,
            ui: .none,
            output: directory
        )

        XCTAssertTrue(FileManager.default.fileExists(atPath: directory.appendingPathComponent("Profile/ProfileContract.swift").path))
        XCTAssertTrue(FileManager.default.fileExists(atPath: directory.appendingPathComponent("Profile/ProfileFlow.swift").path))
        XCTAssertFalse(FileManager.default.fileExists(atPath: directory.appendingPathComponent("Profile/Profile.intentflow.yaml").path))
    }

    func testGeneratorWritesAIManifest() throws {
        let directory = URL(fileURLWithPath: NSTemporaryDirectory())
            .appendingPathComponent(UUID().uuidString, isDirectory: true)

        try IntentFlowGenerate.generate(
            name: "Checkout",
            mode: .ai,
            ui: .none,
            output: directory
        )

        XCTAssertTrue(FileManager.default.fileExists(atPath: directory.appendingPathComponent("Checkout/Checkout.intentflow.yaml").path))
    }

    func testValidateLoadsManifest() throws {
        let directory = URL(fileURLWithPath: NSTemporaryDirectory())
            .appendingPathComponent(UUID().uuidString, isDirectory: true)

        try IntentFlowGenerate.generate(
            name: "Checkout",
            mode: .ai,
            ui: .none,
            output: directory
        )

        let manifest = try IntentFlowGenerate.loadManifest(
            at: directory.appendingPathComponent("Checkout/Checkout.intentflow.yaml")
        )

        XCTAssertEqual(manifest.feature, "Checkout")
        XCTAssertEqual(manifest.mode, .ai)
        XCTAssertEqual(manifest.states.first, "idle")
    }

    func testAIContextRendersToolSpecificInstructions() throws {
        let manifest = FlowManifest(
            feature: "Login",
            mode: .ai,
            summary: "Authenticate a user.",
            states: ["idle", "authenticated(userID)"],
            intents: ["submit(email,password)"],
            events: ["tokenReceived(userID)"],
            effects: ["requestToken"],
            routes: ["twoFactor"],
            outputs: ["completed(userID)"],
            invariants: ["authenticated must always include a userID."],
            acceptanceTraces: ["idle + submit -> requestToken effect"]
        )

        let context = AIContextTemplate.render(manifest: manifest, tool: .codex)

        XCTAssertTrue(context.contains("Feature: Login"))
        XCTAssertTrue(context.contains("Tool: Codex"))
        XCTAssertTrue(context.contains("AGENTS.md"))
        XCTAssertTrue(context.contains("authenticated must always include a userID."))
        XCTAssertTrue(context.contains("swift run intentflow validate <manifest-path>"))
    }
}
