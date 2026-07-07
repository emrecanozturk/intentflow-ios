# Architecture Lifecycle

IntentFlow features move through a predictable lifecycle.

## 1. Product Workflow

Start with behavior, not files.

Ask:

- What can the feature be doing?
- What can the user ask for?
- What can the outside world return?
- What side effects are needed?
- What screens can be opened?
- What does the parent need to know?
- What must always be true?

## 2. Contract

Write the contract as Swift types, and in AI mode as a manifest.

The contract should answer:

- state names
- intent names
- event names
- effect names
- route names
- output names
- invariant statements
- acceptance traces

## 3. Reducer

The reducer turns signals into next behavior.

It can:

- return next state
- request effects
- emit outputs
- emit routes
- request cancellation

It cannot:

- call a service directly
- read persistent storage
- mutate global state
- push screens directly
- call UI APIs

## 4. Effects

Effect handlers execute side work and return events.

Common effect handler dependencies:

- API clients
- repositories
- keychain wrappers
- analytics clients
- permission services
- clocks
- file systems

## 5. Projection

Projection converts state into UI state.

Example mapping:

| Feature State | UI Projection |
|---|---|
| `.idle` | form enabled, no spinner |
| `.validating` | form disabled, spinner visible |
| `.failed(message)` | error label visible, retry enabled |
| `.authenticated` | success state |

## 6. UI Adapter

SwiftUI and UIKit should:

- render projected state
- send intents
- observe store snapshots
- hand routes to a router
- hand outputs to a parent

They should not own workflow transitions.

## 7. Tests

Write tests for:

- pure reducer traces
- cancellation decisions
- effect-to-event loops
- route output
- parent output
- manifest validation
- generator smoke output

## 8. Release

Before release-facing changes:

```bash
./scripts/check.sh
```

CI verifies:

- Swift package tests
- generator smoke
- manifest validation
- demo app build
- documentation build
- CodeQL scanning

## Good Feature Shape

A good IntentFlow feature has:

- a clear finite state list
- effects that are named after product work
- routes and outputs that are visible
- tests that read like acceptance traces
- UI that can be replaced without changing workflow behavior
