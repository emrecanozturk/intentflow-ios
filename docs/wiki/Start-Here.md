# Start Here

This page is the shortest useful path through IntentFlow.

## 1. Verify The Package

```bash
git clone https://github.com/emrecanozturk/intentflow-ios.git
cd intentflow-ios
swift test
swift run intentflow validate .intentflow/login.intentflow.yaml
```

For the full local release check:

```bash
./scripts/check.sh
```

## 2. Learn The Sentence

IntentFlow models a feature as:

```text
State + Intent/Event -> Next State + Effects + Outputs + Routes
```

If a feature cannot be explained through that sentence, the workflow contract is probably not clear enough yet.

## 3. Pick A Feature

Good first candidates:

- login with two-factor recovery
- checkout with payment retry
- upload with progress and cancellation
- permission request with fallback
- device connection with trust and recovery
- onboarding with branching routes

Avoid starting with a simple static screen. IntentFlow is most useful when behavior is doing real work.

## 4. Draw The Contract

Before writing UI, list:

- states
- user intents
- external events
- effect requests
- routes
- parent outputs
- invariants
- acceptance traces

Example:

```text
idle + submit -> validating + validateCredentials effect
validating + credentialsValid -> requestingToken + requestToken effect
requestingToken + tokenRequiresTwoFactor -> waitingForTwoFactor
requestingToken + tokenReceived -> authenticated + completed output
```

## 5. Generate A Starting Point

Core mode:

```bash
swift run intentflow feature Profile --mode core --ui none --output ./Sources/Features
```

AI mode:

```bash
swift run intentflow feature Checkout --mode ai --ui swiftui --output ./Sources/Features
```

## 6. Write Behavior Tests First

The reducer is pure. Test transitions before wiring UI:

```swift
let trace = LoginFlow().trace(
    initialState: .idle,
    signals: [
        .intent(.submit(email: "user@example.com", password: "secret")),
        .event(.credentialsValid)
    ]
)
```

## 7. Add UI Last

SwiftUI views and UIKit view controllers should adapt to projected state and send intents. They should not own workflow rules.

## 8. Use AI Safely

For AI mode, generate a compact context file:

```bash
swift run intentflow ai-context .intentflow/login.intentflow.yaml --tool codex
```

Give the agent that output plus a small task. Do not ask an agent to infer the whole architecture from the repository.
