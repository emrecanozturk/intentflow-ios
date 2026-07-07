# Examples and Recipes

The examples are intentionally workflow-shaped. They are not static screens.

## SwiftUI Example

Path:

```text
Examples/SwiftUIExample
```

Use it to study:

- observing store snapshots
- sending intents from SwiftUI
- projecting feature state into view state
- keeping connection behavior outside the view

Good workflow pressures:

- trust checks
- connection state
- failure and recovery
- output routing

## UIKit Example

Path:

```text
Examples/UIKitExample
```

Use it to study:

- adapting a view controller to a store
- avoiding Massive View Controller behavior
- keeping upload retry and cancellation in the flow
- rendering projected state

Good workflow pressures:

- progress
- retry
- cancellation
- error display

## Demo App

Path:

```text
Examples/IntentFlowDemoApp
```

Build:

```bash
xcodebuild -project Examples/IntentFlowDemoApp/IntentFlowDemoApp.xcodeproj \
  -scheme IntentFlowDemoApp \
  -destination "generic/platform=iOS Simulator" \
  CODE_SIGNING_ALLOWED=NO build
```

## Common Recipes

### Login With Two-Factor

States:

```text
idle
validating
requestingToken
waitingForTwoFactor
failed(message)
authenticated(userID)
```

Key rule:

```text
Two-factor code can only be submitted from waitingForTwoFactor.
```

### Upload With Cancellation

States:

```text
idle
selectingFile
uploading(progress)
failed(message)
completed(remoteID)
```

Use a stable cancellation ID:

```text
upload.current
```

### Permission Flow

States:

```text
idle
requestingPermission
permissionDenied
ready
failed(message)
```

Routes:

```text
settings
```

### Checkout

States:

```text
idle
validatingCart
authorizingPayment
failed(message)
completed(orderID)
```

Outputs:

```text
orderCompleted(orderID)
```

## Example Quality Bar

New examples should include:

- at least three states
- at least one side effect
- one failure path
- one test
- clear route or output when relevant
- no business logic in UI
