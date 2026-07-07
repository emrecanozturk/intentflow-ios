# Core Concepts

IntentFlow uses a small vocabulary. The names are intentionally explicit so feature behavior can be discussed by product, engineering, testing, and AI tools.

## State

`State` describes where a feature is now.

Good states are product states, not UI implementation details:

```swift
enum UploadState {
    case idle
    case selectingFile
    case uploading(progress: Double)
    case failed(message: String)
    case completed(remoteID: String)
}
```

Avoid states like `buttonDisabled` or `spinnerVisible`. Those belong in projection.

## Intent

`Intent` is something the user or UI adapter asks the feature to do.

Examples:

- `.submit`
- `.retry`
- `.cancel`
- `.appear`
- `.selectFile`

Intents should not perform work directly. They enter the reducer.

## Event

`Event` is something the outside world reports back.

Examples:

- `.credentialsValid`
- `.tokenReceived`
- `.uploadProgress`
- `.networkFailed`
- `.permissionDenied`

Events usually come from effect handlers, app services, or child flows.

## Effect

`Effect` is a typed request for side work.

Examples:

- validate credentials
- request token
- upload file
- save draft
- request permission
- send analytics

Reducers request effects. Effect handlers execute them.

## Output

`Output` is a typed message to a parent flow or app shell.

Examples:

- `.completed(userID)`
- `.cancelled`
- `.draftSaved`
- `.requiresAccountUpgrade`

Use outputs instead of hidden callbacks.

## Route

`Route` is a typed navigation request.

Examples:

- `.twoFactor`
- `.paymentSheet`
- `.settings`
- `.close`

Reducers may emit routes. Routers interpret them.

## Projection

`Projection` maps feature state into UI-friendly view state.

This is where labels, button enabled state, colors, visibility, and formatting belong.

## Reducer

The reducer owns behavior:

```text
current state + signal -> next state + effects + outputs + routes
```

Reducers must remain pure:

- no network calls
- no timers
- no persistence
- no UIKit or SwiftUI calls
- no direct navigation

## Store

`FlowStore` is the runtime boundary. It receives intents/events, calls the reducer, runs effect handlers, records history, and notifies observers.

## Cancellation ID

Long-running or replaceable effects should have stable IDs:

```swift
.effect(.search(query), id: "search.query", policy: .cancelInFlight)
```

This makes async behavior visible and testable.
