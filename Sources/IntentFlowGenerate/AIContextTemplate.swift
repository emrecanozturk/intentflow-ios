import Foundation
import IntentFlowAI

enum AITool: String, CaseIterable {
    case codex
    case claude
    case gemini
    case copilot
    case generic

    var displayName: String {
        switch self {
        case .codex:
            return "Codex"
        case .claude:
            return "Claude Code"
        case .gemini:
            return "Gemini CLI"
        case .copilot:
            return "GitHub Copilot"
        case .generic:
            return "Generic AI agent"
        }
    }

    var entryFiles: [String] {
        switch self {
        case .codex:
            return ["AGENTS.md", ".ai/agent-context.md"]
        case .claude:
            return ["CLAUDE.md", "AGENTS.md", ".claude/rules/*.md", ".ai/agent-context.md"]
        case .gemini:
            return ["GEMINI.md", ".geminiignore", ".ai/agent-context.md"]
        case .copilot:
            return [".github/copilot-instructions.md", ".github/instructions/*.instructions.md", ".ai/agent-context.md"]
        case .generic:
            return ["AGENTS.md", ".ai/agent-context.md"]
        }
    }

    var guidance: [String] {
        switch self {
        case .codex:
            return [
                "Use AGENTS.md as the durable repository instruction surface.",
                "Read only the manifest and touched Swift files before editing.",
                "Report verification commands and results at the end."
            ]
        case .claude:
            return [
                "Use CLAUDE.md for session memory and path-scoped .claude/rules files for focused context.",
                "Keep the working set below the manifest, contract, reducer, effects, projection, and tests.",
                "Ask for a design decision when an invariant conflicts with the requested change."
            ]
        case .gemini:
            return [
                "Use GEMINI.md for persistent project context and .geminiignore to skip noisy files.",
                "Prefer compact context from this command over broad directory reads.",
                "Use the manifest as the plan before suggesting code."
            ]
        case .copilot:
            return [
                "Use repository-wide Copilot instructions plus path-specific .instructions.md files.",
                "Review for reducer purity, manifest alignment, route/output typing, and tests.",
                "Do not accept generated code that changes behavior without trace coverage."
            ]
        case .generic:
            return [
                "Use the manifest as the contract.",
                "Keep context focused on touched feature files.",
                "Verify with tests and manifest validation."
            ]
        }
    }
}

struct AIContextTemplate {
    static func render(manifest: FlowManifest, tool: AITool) -> String {
        """
        # IntentFlow AI Context

        Feature: \(manifest.feature)
        Mode: \(manifest.mode.rawValue)
        Tool: \(tool.displayName)
        Summary: \(manifest.summary.isEmpty ? "No summary provided." : manifest.summary)

        ## Entry Files
        \(bulletList(tool.entryFiles))

        ## Tool Guidance
        \(bulletList(tool.guidance))

        ## Contract
        States:
        \(indentedList(manifest.states))

        Intents:
        \(indentedList(manifest.intents))

        Events:
        \(indentedList(manifest.events))

        Effects:
        \(indentedList(manifest.effects))

        Routes:
        \(indentedList(manifest.routes))

        Outputs:
        \(indentedList(manifest.outputs))

        ## Invariants
        \(bulletList(manifest.invariants))

        ## Acceptance Traces
        \(bulletList(manifest.acceptanceTraces))

        ## Required Rules
        - Update the manifest before changing AI-mode Swift contracts.
        - Keep reducers pure and deterministic.
        - Put async work in FlowEffectHandler.
        - Use EffectID for cancellable or replaceable work.
        - Keep SwiftUI and UIKit as adapters over projections.
        - Add reducer trace tests for every new behavior branch.

        ## Verification
        - swift test
        - swift run intentflow validate <manifest-path>
        - swift run intentflow ai-context <manifest-path> --tool \(tool.rawValue)
        """
    }

    private static func bulletList(_ values: [String]) -> String {
        guard !values.isEmpty else {
            return "- none"
        }
        return values.map { "- \($0)" }.joined(separator: "\n")
    }

    private static func indentedList(_ values: [String]) -> String {
        guard !values.isEmpty else {
            return "  - none"
        }
        return values.map { "  - \($0)" }.joined(separator: "\n")
    }
}
