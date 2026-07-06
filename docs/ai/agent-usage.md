# AI Agent Usage

IntentFlow AI is designed to work with coding agents without asking them to read the whole repository. The manifest is the contract, and the agent instruction files explain how to turn that contract into code.

## Supported Agent Surfaces

| Tool | Repository Surface | Best Use |
|---|---|---|
| Codex | `AGENTS.md`, `.ai/agent-context.md`, `intentflow ai-context` | Feature generation, migrations, tests, release work. |
| Claude Code | `CLAUDE.md`, `.claude/rules/*.md`, `intentflow ai-context --tool claude` | Focused feature edits with path-scoped rules. |
| Gemini CLI | `GEMINI.md`, `.geminiignore`, `intentflow ai-context --tool gemini` | Planning, broad review, context-aware analysis. |
| GitHub Copilot | `.github/copilot-instructions.md`, `.github/instructions/*.instructions.md` | Inline help, PR review, path-specific guidance. |
| Cursor | `.cursor/rules/intentflow.mdc` | Editor-native generation and refactoring. |

## Compact Context Flow

Use the CLI before asking an agent to implement or review an AI-mode feature:

```bash
swift run intentflow ai-context .intentflow/login.intentflow.yaml --tool codex
swift run intentflow ai-context .intentflow/login.intentflow.yaml --tool claude
swift run intentflow ai-context .intentflow/login.intentflow.yaml --tool gemini
swift run intentflow ai-context .intentflow/login.intentflow.yaml --tool copilot
```

The command produces a compact Markdown brief with:

- feature summary
- states, intents, events, effects, routes, and outputs
- invariants
- acceptance traces
- provider-specific entry files
- required verification commands

This lets agents operate from the same contract humans review.

## Codex

Codex should start from `AGENTS.md`. For feature work, give it the compact context output and the manifest path:

```text
Read AGENTS.md and .ai/agent-context.md.
Use:
swift run intentflow ai-context .intentflow/login.intentflow.yaml --tool codex

Implement <workflow change>.
Keep reducers pure, update tests, and run validation.
```

Codex is a good fit for multi-file implementation because it can edit, run tests, and report verification in one loop.

## Claude Code

Claude should start from `CLAUDE.md`. Path-scoped rules in `.claude/rules` keep Swift and documentation guidance separate, so Claude does not need every rule for every task.

Use this prompt shape:

```text
Read CLAUDE.md, AGENTS.md, and the manifest.
Use:
swift run intentflow ai-context .intentflow/login.intentflow.yaml --tool claude

Change <behavior>.
Only inspect the manifest, contract, reducer, effects, projection, and tests unless blocked.
```

## Gemini CLI

Gemini should start from `GEMINI.md`. `.geminiignore` keeps noisy build, Git, media, and Xcode user-state files out of normal context.

Use Gemini for:

- comparing a planned workflow against invariants
- reviewing migration plans
- finding missing acceptance traces
- explaining architecture choices from docs

## GitHub Copilot

Copilot uses repository-wide instructions and path-specific files:

- `.github/copilot-instructions.md`
- `.github/instructions/intentflow-swift.instructions.md`
- `.github/instructions/intentflow-docs.instructions.md`

Copilot review should focus on:

- manifest and Swift contract alignment
- reducer purity
- effect cancellation
- route/output typing
- test coverage for transition changes

## Source Notes

- OpenAI documents `AGENTS.md` as the project-level instruction surface for Codex: <https://developers.openai.com/codex/guides/agents-md>
- Anthropic documents `CLAUDE.md` and path-scoped `.claude/rules` for Claude Code memory: <https://docs.anthropic.com/en/docs/claude-code/memory>
- Gemini CLI documents `GEMINI.md` context files and hierarchy: <https://google-gemini.github.io/gemini-cli/docs/cli/gemini-md.html>
- GitHub documents Copilot repository-wide and path-specific custom instructions: <https://docs.github.com/copilot/customizing-copilot/adding-custom-instructions-for-github-copilot>
