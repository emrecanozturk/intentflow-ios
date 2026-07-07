# FAQ

## Is IntentFlow production-ready?

IntentFlow is a `0.1.x` architecture proposal. The package builds, tests, includes examples, generator support, CI, documentation checks, CodeQL scanning, release notes, and security reporting. Try it on one non-trivial feature before standardizing a full app around it.

## Is this just MVVM with different names?

No. MVVM usually centers presentation state and view interaction. IntentFlow centers workflow behavior: state transitions, typed side effects, routes, outputs, and tests.

## Does it replace TCA?

No. TCA is mature and feature-rich. IntentFlow is smaller, framework-light, and focused on explicit workflows plus an AI-readable contract layer.

## Does it require SwiftUI?

No. SwiftUI and UIKit are both adapters.

## Does it replace Clean Architecture?

No. It can sit inside Clean Architecture. Effects can call use cases, repositories, or capability protocols.

## Why split Intent and Event?

Intent is what the user or UI asks for. Event is what the outside world returns. The split makes async workflows easier to reason about.

## Why separate Route and Output?

Routes are navigation requests. Outputs are parent communication. Keeping them separate avoids hidden callbacks and imperative navigation from reducers.

## Why use manifests?

Manifests make AI-assisted work safer. They give coding agents a compact contract with states, intents, events, effects, routes, outputs, invariants, and acceptance traces.

## Can I use Core first and AI later?

Yes. Start with Core when the human contract is still forming. Add AI mode once the feature has stable behavior.

## Where should I start?

Start with [Start Here](Start-Here), then read [Core Concepts](Core-Concepts), then generate one feature.
