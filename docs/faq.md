# FAQ

## Is IntentFlow production-ready?

IntentFlow is currently a `0.1.x` architecture proposal. The package builds, tests, and ships with examples, CI, documentation checks, and release notes. The recommended adoption path is to try it on one non-trivial feature before standardizing a full app around it.

## What problem does it solve?

It makes product behavior explicit:

```text
State + Intent/Event -> Next State + Effects + Outputs + Routes
```

That helps when a feature has async work, cancellation, navigation, retry, recovery, analytics, parent communication, or AI-assisted generation.

## How is it different from MVVM?

MVVM separates view presentation from UI code, but ViewModels often accumulate networking, routing, retry, analytics, and workflow rules. IntentFlow puts workflow transitions in a reducer, side effects in handlers, display formatting in projections, and UI in adapters.

## How is it different from TCA?

TCA is a mature, feature-rich framework. IntentFlow is intentionally smaller and framework-light. It borrows the value of explicit state transitions while adding route/output modeling and an AI-readable manifest layer.

## How is AI mode different from normal code generation?

AI mode adds a manifest with states, intents, events, effects, routes, outputs, invariants, and acceptance traces. Agents work from that contract instead of inferring architecture from scattered files.

## Which AI tools are supported?

The repository includes guidance for:

- Codex through `AGENTS.md`
- Claude Code through `CLAUDE.md` and `.claude/rules`
- Gemini CLI through `GEMINI.md` and `.geminiignore`
- GitHub Copilot through `.github/copilot-instructions.md` and `.github/instructions`
- Cursor through `.cursor/rules`

## Does IntentFlow require SwiftUI?

No. SwiftUI and UIKit are both supported as adapters. See `Examples/SwiftUIExample` and `Examples/UIKitExample`.

## Does IntentFlow replace Clean Architecture?

No. It can sit inside or beside Clean Architecture. IntentFlow defines feature behavior and effect boundaries; your app can still use repositories, service clients, dependency injection, and domain modules.

## Where should I start?

Start with a feature that has at least three states and one side effect. Login, checkout, upload retry, permissions, device connection, and onboarding are good candidates.
