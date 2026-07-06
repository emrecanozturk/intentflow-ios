# IntentFlow Agent Context

IntentFlow is a Swift package that proposes a workflow-first architecture for iOS apps. The key idea is:

```text
State + Intent/Event -> Next State + Effects + Outputs + Routes
```

## Repository Map

- `Sources/IntentFlow`: core runtime, reducer/store/effect/projection/trace types.
- `Sources/IntentFlowAI`: manifest model, parser, validator, AI generation plan.
- `Sources/IntentFlowGenerate`: CLI for feature generation, manifest validation, and AI context rendering.
- `Tests/IntentFlowTests`: runtime behavior tests.
- `Tests/IntentFlowAITests`: manifest parser and validator tests.
- `Tests/IntentFlowGenerateTests`: generator and CLI support tests.
- `Examples/SwiftUIExample`: SwiftUI adapter example.
- `Examples/UIKitExample`: UIKit adapter example.
- `Examples/IntentFlowDemoApp`: buildable demo app.
- `docs/ai`: AI-mode guidance, token budgeting, and agent usage.
- `.intentflow`: schema and sample manifests.
- `.github`, `.claude`, `.cursor`, `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`: agent instruction surfaces.

## First Files For AI Work

1. `AGENTS.md`
2. `.ai/agent-context.md`
3. The relevant `.intentflow/*.intentflow.yaml` manifest.
4. The matching contract, reducer, effect handler, projection, and tests.

## Invariants

- Reducers are pure.
- Effects are typed and cancellable.
- UI is an adapter, not the workflow owner.
- Routes and outputs are explicit.
- AI-generated changes are incomplete without tests.

## Useful Commands

```bash
swift test
swift run intentflow validate .intentflow/login.intentflow.yaml
swift run intentflow ai-context .intentflow/login.intentflow.yaml --tool codex
./scripts/check.sh
```
