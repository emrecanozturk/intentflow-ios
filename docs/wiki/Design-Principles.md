# Design Principles

IntentFlow exists because many iOS features are no longer simple screens. They are workflows with async work, cancellation, navigation, recovery, parent communication, and test expectations.

The architecture starts from product behavior, then lets UI and infrastructure adapt to that behavior.

## The Problem

Common iOS patterns often begin with a screen or layer:

```text
View -> ViewModel / Presenter -> UseCase -> Repository
```

That can work well for simple screens. It becomes harder when one feature needs:

- multiple async phases
- retry and cancellation
- permission or trust recovery
- typed navigation
- communication back to a parent flow
- AI-generated edits that must stay inside boundaries

IntentFlow makes the workflow contract visible first.

```text
State + Intent/Event -> Next State + Effects + Outputs + Routes
```

## Principles

| Principle | Meaning |
|---|---|
| Product behavior first | Model what the feature can do before choosing files or UI structure. |
| Reducers stay pure | Reducers decide transitions; they do not call services, storage, timers, or UI APIs. |
| Effects are typed | Side work is requested explicitly and executed outside the reducer. |
| Routes are explicit | Navigation is a value emitted by behavior, then interpreted by UI or coordinators. |
| Outputs replace hidden callbacks | Parent communication is typed, testable, and reviewable. |
| UI is an adapter | SwiftUI and UIKit render projections and send intents. |
| Tests read like traces | Reducer tests should look like product acceptance traces. |
| AI needs contracts | Coding agents need manifests, invariants, acceptance traces, and scoped instructions. |

## What IntentFlow Is

IntentFlow is:

- a small runtime boundary
- a feature modeling pattern
- a testing style
- a generator for starting points
- an optional AI-readable contract layer
- a migration path for overloaded ViewModels and scattered coordinators

## What IntentFlow Is Not

IntentFlow is not:

- a complete app framework
- a replacement for all MVVM usage
- a dependency injection framework
- a UI framework
- a persistence framework
- a promise that AI can make product decisions without review

## Decision Rules

Use IntentFlow when the feature has meaningful workflow behavior.

Good candidates:

- login with two-factor recovery
- checkout with payment retry
- upload with progress and cancellation
- device connection with trust and network verification
- onboarding with branching routes
- permission request with fallback paths

Avoid IntentFlow when the feature is only:

- static text
- a simple detail screen
- a small form with no async workflow
- a one-off view that will not grow

## How It Relates To Existing Patterns

| Pattern | Keep | IntentFlow Adds |
|---|---|---|
| MVC | Native UI and controller lifecycle | Moves workflow behavior out of view controllers. |
| MVVM | Projection and binding ergonomics | Splits workflow transitions from display state. |
| Coordinators | Navigation execution | Moves navigation decisions into typed routes. |
| Clean Architecture | Dependency direction and use cases | Gives use cases a typed workflow caller. |
| VIPER | Responsibility boundaries | Keeps boundaries with less file ceremony. |
| TCA | Reducer thinking and testability | Offers a smaller runtime plus AI contract guidance. |
| RIBs | Nested workflow thinking | Makes adoption smaller for normal app features. |

## Anti-Patterns

Avoid these shapes:

- a reducer that calls an API client directly
- a ViewModel that owns half the workflow while the reducer owns the other half
- a route emitted from an effect handler instead of behavior
- a closure used for parent communication when an output would be clearer
- a manifest that disagrees with Swift types
- an AI prompt that asks for broad rewrites without acceptance traces

## Success Criteria

IntentFlow is helping when:

- the state list is understandable
- failure and recovery paths are visible
- tests explain the feature without launching UI
- UI code becomes thinner
- code review can discuss behavior instead of hidden callbacks
- AI-generated changes stay close to the manifest and tests
