# AI Agent Playbook

IntentFlow AI is designed to reduce context load and prevent architecture drift.

## Supported Tools

| Tool | Repo Surface | Best Use |
|---|---|---|
| Codex | `AGENTS.md`, `.ai/agent-context.md`, `intentflow ai-context` | Multi-file implementation, tests, release checks. |
| Claude Code | `CLAUDE.md`, `.claude/rules/*.md` | Focused feature edits and refactors. |
| Gemini CLI | `GEMINI.md`, `.geminiignore` | Review, planning, broad analysis. |
| GitHub Copilot | `.github/copilot-instructions.md`, `.github/instructions/*.instructions.md` | Inline help, PR review, path-specific guidance. |
| Cursor | `.cursor/rules/intentflow.mdc` | Editor-native generation and refactoring. |

## Context Order

Do not start by loading the whole repository.

Use this order:

1. `AGENTS.md` or the provider entry file
2. `.ai/agent-context.md`
3. the relevant `.intentflow.yaml`
4. `swift run intentflow ai-context <manifest> --tool <tool>`
5. feature contract, reducer, effects, projection, tests
6. docs only if behavior or public guidance changes

## Token Budget Rules

- Use manifests instead of long prompts.
- Ask for one workflow change at a time.
- Keep acceptance traces short and concrete.
- Exclude `.build`, `DerivedData`, screenshots, and generated project noise.
- Keep provider-specific rules path-scoped.
- Let tests and manifests explain behavior.

## Prompt Shape

```text
Read AGENTS.md and .ai/agent-context.md.
Use:
swift run intentflow ai-context .intentflow/login.intentflow.yaml --tool codex

Task:
Add a lockedOut state after three failed token attempts.

Rules:
- update the manifest first
- keep reducer pure
- update projection and tests
- run swift test and manifest validation
```

## What Agents Must Not Do

Agents must not:

- add side effects inside reducers
- push screens directly from reducers
- hide parent communication in callbacks
- add states without updating tests
- modify generated contracts without updating the manifest
- skip failure, retry, cancellation, or recovery paths when the workflow needs them

## Review AI Output

Review every AI change with this checklist:

- Did the manifest change match Swift types?
- Did reducer transitions stay pure?
- Did effects remain typed?
- Are route and output changes explicit?
- Are acceptance traces still true?
- Do tests cover success and failure?
- Did the agent avoid unrelated rewrites?

## Provider Notes

Codex is best for implementation loops because it can edit files and run tests.

Claude Code is useful for focused edits when the relevant files are known.

Gemini is useful for planning and review, especially when comparing docs and patterns.

Copilot is useful inside the editor and PR review, but it should still follow repo instructions.

Cursor is useful when the manifest and rules are available inside the editor.
