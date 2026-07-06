# IntentFlow Copilot Instructions

This repository uses IntentFlow architecture.

When generating or editing code:

- Model product behavior before UI.
- Add or update `State`, `Intent`, `Event`, `Effect`, `Output`, and `Route` before writing adapters.
- Keep reducers pure. Do not call network, database, analytics, storage, timers, or UI APIs from reducers.
- Put async work in `FlowEffectHandler`.
- Use `EffectID` for long-running, repeatable, or replaceable work.
- Represent navigation as `Route`.
- Represent parent communication as `Output`.
- Keep SwiftUI views and UIKit view controllers as adapters.
- Put display formatting in `FlowProjection`.
- Add transition tests for every new workflow branch.
- For AI mode, update the `.intentflow.yaml` manifest before changing the Swift contract.
- Do not add hidden callbacks when a typed output or route would express the behavior.

Generated code is incomplete unless it includes tests for the transition it introduces.
