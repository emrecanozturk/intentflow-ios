import Foundation

public struct ManifestIssue: Equatable, Sendable {
    public enum Severity: String, Equatable, Sendable {
        case error
        case warning
    }

    public let severity: Severity
    public let message: String

    public init(severity: Severity, message: String) {
        self.severity = severity
        self.message = message
    }
}

public struct FlowManifestValidator: Sendable {
    public init() {}

    public func validate(_ manifest: FlowManifest) -> [ManifestIssue] {
        var issues: [ManifestIssue] = []

        if manifest.feature.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            issues.append(.init(severity: .error, message: "feature must not be empty"))
        }

        if manifest.states.isEmpty {
            issues.append(.init(severity: .error, message: "at least one state is required"))
        }

        if manifest.intents.isEmpty {
            issues.append(.init(severity: .error, message: "at least one intent is required"))
        }

        if manifest.mode == .ai {
            if manifest.invariants.isEmpty {
                issues.append(.init(severity: .error, message: "AI mode requires explicit invariants"))
            }

            if manifest.acceptanceTraces.isEmpty {
                issues.append(.init(severity: .error, message: "AI mode requires acceptance traces"))
            }
        }

        let loweredStates = manifest.states.map { $0.lowercased() }
        if !loweredStates.contains(where: { $0.contains("error") || $0.contains("failed") }) {
            issues.append(.init(severity: .warning, message: "consider modeling failure as an explicit state"))
        }

        if !loweredStates.contains(where: { $0.contains("loading") || $0.contains("request") || $0.contains("progress") }) {
            issues.append(.init(severity: .warning, message: "consider modeling async work as an explicit state"))
        }

        return issues
    }

    public func makePlan(for manifest: FlowManifest) -> AIGenerationPlan {
        let baseFiles = [
            "\(manifest.feature)Contract.swift",
            "\(manifest.feature)Flow.swift",
            "\(manifest.feature)Effects.swift",
            "\(manifest.feature)Projection.swift",
            "\(manifest.feature)Tests.swift"
        ]

        let aiFiles = [
            "\(manifest.feature).intentflow.yaml",
            "\(manifest.feature)Prompts.md"
        ]

        return AIGenerationPlan(
            featureName: manifest.feature,
            mode: manifest.mode,
            requiredFiles: manifest.mode == .ai ? baseFiles + aiFiles : baseFiles,
            guardrails: manifest.invariants,
            testCases: manifest.acceptanceTraces
        )
    }
}
