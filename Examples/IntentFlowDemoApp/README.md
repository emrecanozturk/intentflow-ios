# IntentFlow Demo App

This folder contains a release-oriented SwiftUI demo app.

To run it:

1. Open `IntentFlowDemoApp.xcodeproj`.
2. Select an iOS Simulator.
3. Run the `IntentFlowDemoApp` scheme.

The project is generated from `project.yml` with XcodeGen, and the generated project is committed so the example opens immediately.

Regenerate it with:

```bash
xcodegen generate
```

The demo includes:

- Login flow with failure and success traces
- Checkout flow with payment retry
- Permission flow with settings route
- Device connection source example reference
- UIKit upload source example reference

The purpose is to show product workflows, not a decorative sample app.
