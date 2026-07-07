# Migration Playbook

IntentFlow can be adopted feature by feature. Do not rewrite an app at once.

## Migration Strategy

1. Pick one painful feature.
2. List current states.
3. Convert UI actions into intents.
4. Convert callbacks into events.
5. Move transition decisions into a reducer.
6. Move side effects into an effect handler.
7. Keep existing UI as an adapter.
8. Add tests.
9. Add AI manifest only after the human contract is clear.

## From MVC

Move behavior out of view controllers.

| MVC Problem | IntentFlow Move |
|---|---|
| spinner state in controller | feature state plus projection |
| button handler owns network call | intent plus effect |
| callback pushes next screen | event plus route |
| controller stores workflow flags | explicit state enum |

## From MVVM

Split overloaded ViewModels.

| ViewModel Responsibility | IntentFlow Destination |
|---|---|
| `@Published isLoading` | `State.loading` plus projection |
| button handlers | `Intent` |
| API callback handling | `Event` |
| service calls | `EffectHandler` |
| navigation closures | `Route` |
| parent callbacks | `Output` |
| display formatting | `Projection` |

The ViewModel can temporarily wrap `FlowStore` during migration.

## From Coordinators

Keep coordinators if they are useful as route interpreters.

IntentFlow changes where navigation decisions are made:

```text
Reducer emits Route -> Coordinator interprets Route
```

The reducer decides that navigation should happen. The coordinator decides how.

## From VIPER

Map carefully:

| VIPER | IntentFlow |
|---|---|
| Entity | Domain model |
| Interactor | Effect handler or capability |
| Presenter | Reducer plus projection |
| Router | Route interpreter |
| View | UI adapter |

IntentFlow reduces file ceremony while preserving responsibility boundaries.

## From Clean Architecture

Keep real use cases. Do not create use cases just to satisfy a diagram.

Common shape:

```text
Flow -> Effect -> Capability Protocol -> Infrastructure
```

## From TCA

The mental model is close, but the vocabulary is split differently.

| TCA | IntentFlow |
|---|---|
| State | State |
| Action | Intent/Event split |
| Reducer | FlowReducer |
| Effect | EffectRequest plus FlowEffectHandler |
| Dependency | Capability |
| Navigation | Route |
| Delegate action | Output |

## From RIBs

Start by modeling each interactor workflow as an IntentFlow feature.

Lifecycle mapping:

```text
didBecomeActive -> .intent(.appear)
childFinished -> .event(.childCompleted)
detachChild -> .route(.closeChild)
```

## Stop Conditions

Do not migrate more if:

- the first feature did not become easier to test
- the state list feels fake
- the team cannot name effects clearly
- UI still owns workflow behavior

Fix the modeling before scaling adoption.
