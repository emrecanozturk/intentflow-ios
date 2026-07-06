# MVVM vs IntentFlow

MVVM is useful, but ViewModels often become a place where unrelated responsibilities meet.

## Common MVVM Growth

```swift
final class LoginViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var error: String?
    var onLoginCompleted: (() -> Void)?
    var onShowTwoFactor: (() -> Void)?

    func submit() {
        isLoading = true
        authAPI.login { result in
            self.isLoading = false
            // validation, retry, navigation, output, token handling
        }
    }
}
```

The ViewModel owns:

- UI state
- async work
- navigation
- parent callbacks
- retry
- error mapping
- business transition rules

## IntentFlow Split

| Responsibility | Owner |
|---|---|
| possible states | `State` |
| user input | `Intent` |
| external results | `Event` |
| behavior rules | `FlowReducer` |
| async work | `FlowEffectHandler` |
| navigation | `Route` |
| parent messages | `Output` |
| display formatting | `Projection` |
| rendering | SwiftUI/UIKit adapter |

IntentFlow does not make MVVM illegal. It gives ViewModels a smaller job or replaces them with a thin adapter.
