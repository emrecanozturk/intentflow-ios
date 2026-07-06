# Changelog

## 0.1.1

Launch-ready AI agent support release.

Added:

- multi-agent instruction surfaces for Codex, Claude Code, Gemini CLI, Copilot, and Cursor
- `intentflow ai-context` command for compact provider-specific AI handoffs
- token-budgeting and agent-usage documentation
- path-scoped Claude and Copilot rules
- reusable AI prompt templates under `.intentflow/prompts`
- FAQ, quick start, and social preview asset
- issue templates for AI generation feedback and adoption questions

## 0.1.0

Initial architecture proposal.

Added:

- IntentFlow core runtime
- typed state/intent/event/effect/output/route model
- pure reducer protocol
- actor-backed store
- effect cancellation IDs
- observation tokens
- projection protocol
- trace helper for tests
- IntentFlow AI manifest model
- manifest validator
- feature generator CLI
- SwiftUI device connection example
- UIKit upload retry example
- migration guide
- pattern research matrix
- Cursor and Copilot rules
