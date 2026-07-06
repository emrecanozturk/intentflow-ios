# Agent Instructions

IntentFlow is a workflow-first Swift architecture for iOS. Treat feature behavior as the source of truth, then adapt SwiftUI or UIKit to that behavior.

## Read First

- Start with `.ai/agent-context.md` for the compact repository map.
- For AI-mode feature work, read the feature `.intentflow.yaml` manifest before Swift implementation files.
- For architecture rationale, read `docs/ai/intentflow-ai.md`, `docs/rationale/design-principles.md`, and `docs/advanced/memory-and-concurrency.md`.
- Avoid reading generated Xcode project internals unless the task is explicitly about the demo app project.

## Architecture Rules

- Update the manifest before changing AI-mode state, intent, event, effect, output, or route contracts.
- Keep reducers pure. Reducers must not call networking, persistence, analytics, timers, UI APIs, or start `Task`.
- Put async work in `FlowEffectHandler` and return events to the store.
- Use `EffectID` and cancellation policies for long-running, repeatable, or replaceable work.
- Model navigation as typed `Route` output and parent communication as typed `Output`.
- Keep SwiftUI views and UIKit view controllers as adapters over projected state.
- Add reducer/trace tests for every behavior branch you introduce.

## Commands

```bash
swift test
swift run intentflow validate .intentflow/login.intentflow.yaml
swift run intentflow ai-context .intentflow/login.intentflow.yaml --tool codex
./scripts/check.sh
```

## Token Budget

- Prefer `swift run intentflow ai-context <manifest> --tool <codex|claude|gemini|copilot>` over loading the whole repository.
- Use `.ai/agent-context.md` as the short map and only open files directly touched by the requested change.
- Do not paste complete generated files into discussion unless the user asks for them.

## Release Standard

A change is not ready if it only changes prose or code. It should also update the relevant manifest, tests, docs, and agent instructions when behavior or workflow changes.
