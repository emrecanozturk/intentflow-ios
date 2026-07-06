---
applyTo: "Sources/**/*.swift,Tests/**/*.swift,Examples/**/*.swift"
---

# IntentFlow Swift Instructions

- Model product behavior first: state, intent, event, effect, route, output.
- Keep reducers pure and put side effects in handlers.
- Use `EffectID` for repeatable, cancellable, or replaceable async work.
- Keep SwiftUI views and UIKit view controllers as adapters over projections.
- Generated code is incomplete without tests for the transition it introduces.
- If an AI-mode feature changes, update the `.intentflow.yaml` manifest before or with the Swift contract.
