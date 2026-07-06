# Design Principles

## 1. A Feature Is a Workflow

A feature should be described by its possible states and transitions before UI is written.

Bad starting point:

```text
Create LoginViewModel.
```

Better starting point for a login feature:

```text
Define LoginState, LoginIntent, LoginEvent, LoginEffect, LoginOutput, and LoginRoute.
```

For a different feature, use that feature's own contract types.

## 2. Reducers Are Pure

Reducers do not call the network, touch storage, present view controllers, post analytics, or start timers.

Reducers decide what should happen next:

```text
state + signal -> next state + effect requests + outputs + routes
```

## 3. Effects Are Typed and Cancellable

Effects represent work outside pure behavior:

- network
- storage
- timers
- permissions
- device APIs
- analytics
- file system

Long-running or replacing work should use an `EffectID` and `cancelInFlight`.

## 4. UI Is an Adapter

SwiftUI views and UIKit view controllers:

- render projected state
- send user intents
- handle route outputs through the app shell

They should not own workflow rules.

## 5. Routes Are Data

Navigation is not hidden in reducers as imperative UI calls. Reducers emit routes:

```swift
return .state(.waitingForTwoFactor)
    .route(.twoFactor)
```

The app shell decides how to perform the route.

## 6. Outputs Are Product Signals

Outputs are not navigation. They are feature-level messages:

- login completed
- upload cancelled
- checkout paid
- session ready

Parent flows and app services can react to outputs without knowing UI details.

## 7. Projection Is Separate

Projection converts workflow state into renderable UI state.

This keeps formatting, button titles, visibility, and display rules out of the reducer while still keeping the view simple.

## 8. AI Needs Contracts, Not Wishes

AI tools should not infer architecture from folder names alone.

IntentFlow AI gives them:

- allowed states
- allowed intents
- allowed effects
- invariants
- acceptance traces
- file ownership rules

That makes generated code reviewable instead of magical.
