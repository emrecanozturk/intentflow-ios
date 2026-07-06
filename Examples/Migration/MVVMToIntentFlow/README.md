# MVVM to IntentFlow

This example shows how a growing ViewModel is split into workflow pieces.

## Before

See [BeforeLoginViewModel.swift](BeforeLoginViewModel.swift).

The ViewModel owns:

- loading state
- validation
- async API calls
- navigation callbacks
- error messages
- retry behavior

## After

See:

- [AfterLoginContract.swift](AfterLoginContract.swift)
- [AfterLoginFlow.swift](AfterLoginFlow.swift)

The workflow now owns behavior. A SwiftUI model or UIKit controller only adapts the flow to UI.
