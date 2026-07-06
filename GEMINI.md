# Gemini CLI Instructions

IntentFlow is a workflow-first iOS architecture. The smallest useful context is the manifest plus the files being edited.

## Context Loading

- Read `.ai/agent-context.md` first.
- For AI mode, read the relevant `.intentflow.yaml` file before Swift code.
- Use `.geminiignore` to avoid build products, Git internals, screenshots, and Xcode user state.
- Prefer `swift run intentflow ai-context <manifest> --tool gemini` when asking Gemini for generation, review, or migration help.

## Architecture Rules

- Reducers are pure and return `Next`.
- Effects live in `FlowEffectHandler`.
- SwiftUI and UIKit files are adapters.
- Navigation is a route. Parent communication is an output.
- New behavior requires transition tests and manifest updates.

## Verification

```bash
swift test
swift run intentflow validate .intentflow/login.intentflow.yaml
swift run intentflow ai-context .intentflow/login.intentflow.yaml --tool gemini
```
