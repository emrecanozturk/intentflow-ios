# Migration Guide

IntentFlow can be adopted feature by feature. You do not need to rewrite an app.

## From MVC

Move behavior out of the view controller in this order:

1. List the states currently represented by booleans, labels, spinners, and optional values.
2. Convert button taps and lifecycle events into `Intent`.
3. Convert async callbacks into `Event`.
4. Move transition decisions into `Flow`.
5. Keep the view controller as an adapter that renders projected state.

Before:

```swift
final class LoginViewController: UIViewController {
    func loginTapped() {
        spinner.startAnimating()
        api.login { result in
            self.spinner.stopAnimating()
            self.showHome()
        }
    }
}
```

After:

```swift
await store.send(.submit(email: email, password: password))
```

## From MVVM

Do not delete the ViewModel immediately. First split it:

| MVVM Responsibility | IntentFlow Destination |
|---|---|
| `@Published var isLoading` | `State.loading` plus projection |
| button handlers | `Intent` |
| network callbacks | `Event` |
| API calls | `EffectHandler` |
| navigation closures | `Route` |
| parent callbacks | `Output` |
| formatting | `Projection` |

The ViewModel can become a thin adapter around `FlowStore`, then eventually disappear or become a platform-specific model.

## From VIPER

Map VIPER roles carefully:

| VIPER | IntentFlow |
|---|---|
| Entity | Domain model |
| Interactor | Effect handler or capability |
| Presenter | Projection plus reducer decisions |
| Router | Route interpreter |
| View | UI adapter |

The key migration is moving behavior from Presenter/Interactor pairs into a pure `Flow`.

## From Clean Architecture

Keep use cases when they are real domain operations. Do not create use cases only to satisfy a layer diagram.

IntentFlow works well with Clean boundaries:

```text
Flow -> Effect -> Capability Protocol -> Infrastructure
```

Domain rules can remain pure. Effects call use cases or capabilities.

## From TCA

The mental model is close:

| TCA | IntentFlow |
|---|---|
| State | State |
| Action | Intent/Event split |
| Reducer | FlowReducer |
| Effect | EffectRequest + FlowEffectHandler |
| Dependencies | Capabilities |
| TestStore | trace + FlowStore tests |

IntentFlow intentionally splits user input (`Intent`) from external result (`Event`) and separates `Route` and `Output` as explicit products of a transition.

## From RIBs

Start by modeling each RIB's interactor state as an IntentFlow feature.

Keep builders and dependency scopes if they are already useful. Replace hidden lifecycle decisions with explicit intents/events:

- didBecomeActive -> `.intent(.appear)`
- child finished -> `.event(.childCompleted)`
- detach child -> `.route(.closeChild)`

## Adoption Strategy

1. Pick one painful feature with async behavior.
2. Draw the state list.
3. Write reducer tests first.
4. Move side effects behind `FlowEffectHandler`.
5. Keep existing UI and adapt it to the store.
6. Add AI manifest only after the human contract is clear.
