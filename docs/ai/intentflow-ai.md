# IntentFlow AI

IntentFlow AI is the contract-driven variant of IntentFlow.

It is for teams that use AI tools such as Codex, Cursor, Copilot, Claude Code, or other coding agents and want generated code to obey architectural boundaries.

## Core vs AI

| Concern | Core | AI |
|---|---|---|
| Reducer contract | Swift types | Swift types plus manifest |
| Invariants | Tests and review | Tests, review, and machine-readable rules |
| Generation | Optional CLI | CLI plus `.intentflow.yaml` |
| AI instructions | Optional prose | `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.cursor/rules`, `.github/instructions`, manifest |
| Acceptance traces | Tests | Tests plus prompt-visible contract |
| Context budget | Human judgment | `intentflow ai-context`, provider rules, compact repo map |

## Manifest

Every AI-assisted feature has a manifest:

```yaml
schemaVersion: "0.1"
feature: "Checkout"
mode: "ai"
summary: "Collect payment and complete an order."
states:
  - idle
  - validatingCart
  - authorizingPayment
  - failed(message)
  - completed(orderID)
intents:
  - start
  - retry
  - cancel
events:
  - cartValid
  - paymentAuthorized(orderID)
  - failed(message)
effects:
  - validateCart
  - authorizePayment
routes:
  - paymentSheet
outputs:
  - orderCompleted(orderID)
invariants:
  - "Payment authorization can only start after cart validation succeeds."
  - "completed must always include an orderID."
acceptanceTraces:
  - "idle + start -> validatingCart + validateCart effect"
  - "authorizingPayment + paymentAuthorized -> completed + orderCompleted output"
```

## AI Rules

AI tools should follow these rules:

1. Update the manifest before adding a new state, intent, event, effect, route, or output.
2. Do not perform side effects inside reducers.
3. Add transition tests before or with behavior changes.
4. Represent navigation as `Route`, not direct view calls.
5. Represent parent communication as `Output`, not callbacks hidden in adapters.
6. Add explicit loading and failure states for async work.
7. Use effect IDs for long-running or replaceable effects.
8. Do not put business rules in SwiftUI views or UIKit view controllers.

## Agent Context Command

Generate a compact, provider-specific brief from a manifest:

```bash
swift run intentflow ai-context .intentflow/login.intentflow.yaml --tool codex
swift run intentflow ai-context .intentflow/login.intentflow.yaml --tool claude
swift run intentflow ai-context .intentflow/login.intentflow.yaml --tool gemini
swift run intentflow ai-context .intentflow/login.intentflow.yaml --tool copilot
```

The output is meant to be pasted into or attached to an agent session. It includes the feature contract, invariants, acceptance traces, provider entry files, and verification commands.

## Why This Helps AI

AI-generated code often looks right while breaking behavior:

- it adds a state but forgets tests
- it performs network work in a view model
- it pushes UI from a reducer
- it handles success but not retry/failure
- it invents a route outside the agreed contract

The manifest gives AI a small, explicit design space. The generated code can be checked against invariants and acceptance traces.

## Included Rulesets

- `AGENTS.md`
- `CLAUDE.md`
- `GEMINI.md`
- `.ai/agent-context.md`
- `.claude/rules/*.md`
- `.cursor/rules/intentflow.mdc`
- `.github/copilot-instructions.md`
- `.github/instructions/*.instructions.md`
- `.intentflow/schema.json`
- `.intentflow/login.intentflow.yaml`
- `.intentflow/prompts/*.md`

These files are intentionally repository-local so public contributors and AI tools see the same architectural rules.

## More

- [AI Agent Usage](agent-usage.md)
- [Context Budgeting](context-budgeting.md)
