import XCTest
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
}
