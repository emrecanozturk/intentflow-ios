---
paths:
  - "Sources/**/*.swift"
  - "Tests/**/*.swift"
  - "Examples/**/*.swift"
---

# IntentFlow Swift Rules

- Start from the manifest and contract before editing reducers or UI adapters.
- Keep reducers deterministic and side-effect free.
- Put async work in `FlowEffectHandler`.
- Return typed events from effects.
- Add or update reducer trace tests for new behavior.
- Use `@MainActor` only where UI or observable presentation state requires it.
- Avoid retaining UI objects from effects; prefer value payloads and injected dependencies.
