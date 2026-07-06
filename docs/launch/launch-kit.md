# IntentFlow Launch Kit

Use this file when announcing IntentFlow publicly.

## One-Liner

IntentFlow is a workflow-first, AI-ready architecture for iOS apps that makes product behavior explicit, typed, testable, and safer for coding agents to extend.

## Short Pitch

Most iOS architectures are still screen-first. IntentFlow starts from the actual workflow:

```text
State + Intent/Event -> Next State + Effects + Outputs + Routes
```

SwiftUI and UIKit become adapters. Effects become typed and cancellable. Navigation and parent communication become explicit outputs. AI tools work from a manifest instead of guessing from scattered code.

## Why Now

AI coding tools are good at producing plausible code, but iOS architecture needs more than plausible structure. IntentFlow gives agents a small contract:

- states
- intents
- events
- effects
- routes
- outputs
- invariants
- acceptance traces

That contract keeps humans and agents aligned before code is generated.

## Announcement For X

```text
I just released IntentFlow for iOS.

It is a workflow-first, AI-ready architecture for Swift apps.

State + Intent/Event -> Next State + Effects + Outputs + Routes

SwiftUI/UIKit stay as adapters.
Reducers stay pure.
Effects are typed and cancellable.
AI agents work from a manifest, not guesswork.

Repo:
https://github.com/emrecanozturk/intentflow-ios
```

## Announcement For LinkedIn

```text
I released IntentFlow for iOS today.

It is a workflow-first architecture for Swift apps, designed around explicit product behavior instead of screen-shaped objects.

The core idea:

State + Intent/Event -> Next State + Effects + Outputs + Routes

IntentFlow has two modes:

- Core: a lightweight architecture with pure reducers, typed effects, route/output modeling, projections, and tests.
- AI: Core plus a machine-readable manifest with invariants and acceptance traces so tools like Codex, Claude, Gemini, Copilot, and Cursor can generate code with stricter boundaries.

The goal is not to replace every existing pattern. MVC, MVVM, VIPER, Clean, Coordinators, TCA, and RIBs all solved real problems. IntentFlow starts where those approaches often become unclear: async workflows, cancellation, navigation, recovery, observability, and AI-assisted generation.

The repo includes Swift Package support, SwiftUI and UIKit examples, migration guides, generator CLI, CI, DocC checks, and provider-specific AI instructions.

I would love feedback from iOS engineers who have fought Massive ViewModels, hidden side effects, navigation drift, or AI-generated code that looks correct but breaks behavior.

https://github.com/emrecanozturk/intentflow-ios
```

## Announcement For Swift Forums Or Reddit

```text
I released an experimental iOS architecture proposal called IntentFlow.

The idea is workflow-first architecture:

State + Intent/Event -> Next State + Effects + Outputs + Routes

It is not intended to be a heavy framework. The core package is small and focuses on pure reducers, typed effects, cancellation IDs, outputs/routes, projections, and reducer trace tests.

The AI mode adds `.intentflow.yaml` manifests with invariants and acceptance traces, plus instruction files for Codex, Claude, Gemini, Copilot, and Cursor. The goal is to make AI-assisted feature generation less vague and easier to review.

I am especially looking for feedback on:

- whether the contract shape is useful in real iOS features
- where it overlaps too much with TCA/MVI/RIBs
- what migration paths from MVVM or coordinator-heavy apps should include
- what additional examples would make adoption easier

Repo:
https://github.com/emrecanozturk/intentflow-ios
```

## Hacker News Title Options

- Show HN: IntentFlow, a workflow-first AI-ready architecture for iOS
- IntentFlow: workflow-first architecture for SwiftUI and UIKit apps
- A contract-first iOS architecture designed for human and AI code generation

## Demo Commands

```bash
git clone https://github.com/emrecanozturk/intentflow-ios.git
cd intentflow-ios
swift test
swift run intentflow validate .intentflow/login.intentflow.yaml
swift run intentflow ai-context .intentflow/login.intentflow.yaml --tool codex
swift run intentflow feature Checkout --mode ai --ui swiftui --output /tmp/intentflow-demo
```

## Launch Checklist

- GitHub repo is public.
- CI badge is passing.
- Documentation badge is passing.
- Release `0.1.1` is published.
- README explains the problem in the first screen.
- Quick start is visible.
- SwiftUI and UIKit examples are linked.
- AI agent support is visible.
- Migration guide is linked.
- Issues and Discussions are enabled.
- Repository topics are set.
- Announcement posts link to the repo and ask for concrete feedback.

## Response To Common Pushback

### Is this just TCA?

No. TCA is a mature framework with a rich ecosystem. IntentFlow is smaller and framework-light. It focuses on explicit workflow contracts, typed effects, route/output modeling, and AI-readable manifests.

### Is this just MVVM with more files?

No. MVVM usually centers presentation state and view interaction. IntentFlow centers the product workflow and treats UI as an adapter.

### Does AI mode mean AI writes the app?

No. AI mode gives coding agents a constrained contract: states, intents, effects, invariants, and acceptance traces. It is designed to reduce vague generation, not remove human design.

### Should production apps adopt this today?

Start with one non-trivial feature. Good candidates are login, checkout, permissions, upload/retry, device connection, onboarding, or any workflow with async effects and recovery paths.
