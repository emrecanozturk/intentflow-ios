# Memory and Concurrency

IntentFlow is designed for async iOS workflows without hiding lifetime decisions.

## Store Lifetime

`FlowStore` is an actor. It owns:

- current state
- running effect tasks
- snapshot history
- observers

Effects are started as tasks and are cancelled by `EffectID`.

## Avoiding Retain Cycles

The store does not require UI adapters to retain it forever.

Recommended SwiftUI pattern:

```swift
deinit {
    observation?.cancel()
    bindTask?.cancel()
}
```

Recommended UIKit pattern:

```swift
deinit {
    observation?.cancel()
    bindTask?.cancel()
}
```

When an adapter starts a task, capture `self` weakly:

```swift
Task { [weak self] in
    guard let self else { return }
    await store.send(.appear)
}
```

When an effect wraps `AsyncStream`, cancel internal work on termination:

```swift
continuation.onTermination = { _ in
    task.cancel()
}
```

## Cancellation Rule

Any effect that can outlive the user intent should have an ID:

```swift
.effect(.upload(payload), id: "upload.stream", policy: .cancelInFlight)
```

Then pause, cancel, retry, and deinit flows can stop it deterministically:

```swift
.cancel("upload.stream")
```

## Reducer Rule

Reducers should not contain `Task`, `await`, network clients, database clients, timers, or UI objects.

This is what keeps them memory-safe and testable.

## Adapter Rule

UI adapters may be platform-specific. They are allowed to:

- own labels, views, and SwiftUI bindings
- bind to snapshots
- send intents
- interpret routes

They should not:

- decide product state transitions
- call APIs directly
- store workflow-only booleans such as `isLoadingPayment` when that is already state
