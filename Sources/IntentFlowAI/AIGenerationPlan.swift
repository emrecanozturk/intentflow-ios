import Foundation

public struct AIGenerationPlan: Equatable, Sendable {
    public let featureName: String
    public let mode: IntentFlowMode
    public let requiredFiles: [String]
    public let guardrails: [String]
    public let testCases: [String]

    public init(
        featureName: String,
        mode: IntentFlowMode,
        requiredFiles: [String],
        guardrails: [String],
        testCases: [String]
    ) {
        self.featureName = featureName
        self.mode = mode
        self.requiredFiles = requiredFiles
        self.guardrails = guardrails
        self.testCases = testCases
    }
}
