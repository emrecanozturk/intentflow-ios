# Core vs AI

IntentFlow has two modes.

## IntentFlow Core

Use Core when you want the architecture without extra AI contract files.

Core includes:

- Swift state, intent, event, effect, output, and route types
- pure reducer
- effect handler
- store
- projection
- tests

Core is good for:

- teams not using coding agents
- small packages
- manually written features
- gradual adoption inside existing apps

## IntentFlow AI

Use AI mode when coding agents will create, edit, or review features.

AI mode includes everything in Core plus:

- `.intentflow.yaml` manifest
- invariants
- acceptance traces
- generator validation
- provider-specific AI instructions
- compact `intentflow ai-context` output

AI mode is good for:

- Codex implementation loops
- Claude Code feature edits
- Gemini architecture review
- Copilot inline help and PR review
- Cursor editor-native refactors
- teams that want AI to obey explicit rules

## Difference In One Table

| Concern | Core | AI |
|---|---|---|
| Source of truth | Swift types and tests | Swift types, tests, and manifest |
| AI safety | Human review | Human review plus machine-readable contract |
| Generated files | Swift skeleton | Swift skeleton plus manifest |
| Context budget | Manual judgment | Compact agent context command |
| Drift detection | Tests and code review | Tests, manifest validation, acceptance traces |

## When To Start With Core

Start with Core if:

- the feature contract is still unclear
- the team is learning the pattern
- the feature is small and manually maintained
- you do not want manifest overhead yet

You can add AI mode later.

## When To Start With AI

Start with AI if:

- a coding agent will implement or modify the feature
- the feature has many states
- workflow rules must be stable over time
- reviewers need compact acceptance traces
- you want generated code to stay inside architectural boundaries

## Rule Of Thumb

Core is the architecture.

AI mode is the architecture plus a contract that humans and machines can share.
