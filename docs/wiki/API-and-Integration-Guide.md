# API and Integration Guide

This guide shows how the public IntentFlow pieces fit together in an app.

## Package Targets

| Target | Use |
|---|---|
| `IntentFlow` | Core runtime: reducer, store, effect requests, projections, traces. |
| `IntentFlowAI` | Manifest model, parsing, and validation. |
| `IntentFlowGenerate` | CLI generator and AI context output. |

Most app features only need `IntentFlow`.

## Core Types

| Type | Responsibility |
|---|---|
| `FlowReducer` | Pure transition function for a feature. |
| `FlowSignal` | Wraps either an intent or event. |
| `Next` | Carries next state, effects, outputs, and routes. |
| `EffectRequest` | A typed side-effect request with optional cancellation ID and policy. |
| `FlowEffectHandler` | Executes effects and streams events back. |
| `FlowStore` | Actor that applies reducer output, runs effects, stores history, and notifies observers. |
| `FlowProjection` | Converts product state into UI-friendly view state. |
| `FlowTrace` | Reducer-only trace for behavior tests. |

## Feature Shape

Each feature owns its own vocabulary:

```swift
enum UploadState: Equatable, Sendable {
    case idle
    case selectingFile
    case uploading(progress: Double)
    case failed(message: String)
    case completed(remoteID: String)
}

enum UploadIntent: Equatable, Sendable {
    case selectFile
    case start
    case retry
    case cancel
}

enum UploadEvent: Equatable, Sendable {
    case fileSelected(URL)
    case progress(Double)
    case uploaded(remoteID: String)
    case failed(String)
}
```

## Reducer

Reducers should be pure. They decide what should happen, not how side work is executed.

```swift
struct UploadFlow: FlowReducer {
    func reduce(
        state: UploadState,
        signal: FlowSignal<UploadIntent, UploadEvent>
    ) -> Next<UploadState, UploadEffect, UploadOutput, UploadRoute> {
        switch (state, signal) {
        case (.idle, .intent(.selectFile)):
            return .state(.selectingFile)
                .route(.filePicker)

        case (.selectingFile, .event(.fileSelected(let url))):
            return .state(.uploading(progress: 0))
                .effect(.upload(url), id: "upload.file", policy: .cancelInFlight)

        case (.uploading, .event(.uploaded(let remoteID))):
            return .state(.completed(remoteID: remoteID))
                .output(.completed(remoteID: remoteID))

        case (.uploading, .intent(.cancel)):
            return .state(.idle)
                .cancel("upload.file")

        default:
            return .state(state)
        }
    }
}
```

## Effects

Effect handlers execute side work and send events back to the store.

```swift
struct UploadEffects: FlowEffectHandler {
    let client: UploadClient

    func handle(_ effect: UploadEffect) -> AsyncStream<UploadEvent> {
        AsyncStream { continuation in
            Task {
                switch effect {
                case .upload(let url):
                    do {
                        for try await update in client.upload(url) {
                            switch update {
                            case .progress(let value):
                                continuation.yield(.progress(value))
                            case .completed(let remoteID):
                                continuation.yield(.uploaded(remoteID: remoteID))
                            }
                        }
                    } catch {
                        continuation.yield(.failed(error.localizedDescription))
                    }
                    continuation.finish()
                }
            }
        }
    }
}
```

Keep the effect handler thin. Put real networking, persistence, analytics, or permissions behind app capability protocols.

## Store Integration

Create one store per feature instance:

```swift
let store = FlowStore(
    initialState: UploadState.idle,
    reducer: UploadFlow(),
    effects: UploadEffects(client: client)
)
```

Send user requests:

```swift
await store.send(.selectFile)
```

Feed external events when needed:

```swift
await store.receive(.fileSelected(url))
```

Observe snapshots:

```swift
let observation = await store.observe { snapshot in
    // render state, handle routes, handle outputs
}
```

Keep the returned `FlowObservation` alive for as long as the UI should observe the store. Releasing it cancels the observation.

## Projection

Projection keeps UI details out of product state:

```swift
struct UploadProjection: FlowProjection {
    func project(_ state: UploadState) -> UploadViewState {
        switch state {
        case .idle:
            return UploadViewState(title: "Upload", isBusy: false, error: nil)
        case .uploading(let progress):
            return UploadViewState(title: "\(Int(progress * 100))%", isBusy: true, error: nil)
        case .failed(let message):
            return UploadViewState(title: "Retry", isBusy: false, error: message)
        default:
            return UploadViewState(title: "Upload", isBusy: false, error: nil)
        }
    }
}
```

## SwiftUI

Use SwiftUI as an adapter:

- observe store snapshots
- project state into view state
- send intents from buttons and lifecycle events
- interpret routes in the app navigation layer

Do not put workflow rules in the view body.

## UIKit

Use UIKit view controllers as adapters:

- keep `FlowObservation` as a property
- render projected state in `render(_:)`
- send intents from target actions
- let a coordinator or router interpret routes

Do not let the view controller become the workflow owner again.

## Memory And Lifetime

IntentFlow avoids retain-heavy patterns by keeping the store as an actor and observations cancellable.

Recommended rules:

- cancel observations when the screen disappears permanently
- use stable effect IDs for long-running work
- cancel in-flight effects when replacing search, upload, validation, or connection work
- keep service dependencies outside reducers
- avoid storing UIKit or SwiftUI objects in reducers, states, events, or effects

## Tests

Reducer tests should not create UI or services. Use `trace`:

```swift
let trace = UploadFlow().trace(
    initialState: .idle,
    signals: [
        .intent(.selectFile),
        .event(.fileSelected(url)),
        .event(.uploaded(remoteID: "file-1"))
    ]
)
```

Store tests should cover effect-to-event behavior, observer updates, cancellation, outputs, and routes.
