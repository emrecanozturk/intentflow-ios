# Pattern Research Matrix

This document explains the patterns that influenced IntentFlow and the gaps it tries to close.

IntentFlow is not a rejection of existing iOS architectures. It is a synthesis around a different center: workflow behavior.

## Sources

- Apple, Model-View-Controller: https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/MVC.html
- Apple, Cocoa MVC: https://developer.apple.com/library/archive/documentation/General/Conceptual/CocoaEncyclopedia/Model-View-Controller/Model-View-Controller.html
- objc.io, Lighter View Controllers: https://www.objc.io/issues/1-view-controllers/lighter-view-controllers/
- Martin Fowler, Presentation Model: https://martinfowler.com/eaaDev/PresentationModel.html
- Martin Fowler, Passive View: https://martinfowler.com/eaaDev/PassiveScreen.html
- Martin Fowler, Model View Presenter: https://martinfowler.com/eaaDev/ModelViewPresenter.html
- Soroush Khanlou, Coordinators: https://khanlou.com/2015/01/the-coordinator/
- Uncle Bob, The Clean Architecture: https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html
- Clean Swift: https://clean-swift.com/clean-swift-ios-architecture/
- The Book of VIPER: https://github.com/strongself/The-Book-of-VIPER
- Redux, Three Principles: https://redux.js.org/understanding/thinking-in-redux/three-principles
- The Elm Architecture: https://guide.elm-lang.org/architecture/
- Android Architecture, UI Layer and UDF: https://developer.android.com/topic/architecture/ui-layer
- Point-Free, The Composable Architecture: https://github.com/pointfreeco/swift-composable-architecture
- Uber RIBs: https://github.com/uber/ribs
- GitHub Copilot custom instructions: https://docs.github.com/copilot/customizing-copilot/adding-custom-instructions-for-github-copilot
- Awesome Cursor Rules: https://github.com/PatrickJS/awesome-cursorrules

## Matrix

| Pattern | Strength | Common Pressure Point | IntentFlow Response |
|---|---|---|---|
| MVC | Native to Cocoa, easy to start. | View controllers gather networking, formatting, navigation, validation, and state. | View controllers render projections and send intents only. |
| MVP | Presenter is testable and view can be passive. | Presenter becomes a second controller and often owns too many policy decisions. | Reducer owns transitions; projection owns presentation; adapter owns rendering. |
| MVVM | Good separation between UI and presentation state. | ViewModels become a mixed bag of state, side effects, navigation, analytics, retry, permission, and lifecycle. | IntentFlow splits state transition, effect execution, route output, and projection. |
| Coordinator | Navigation gets a home outside view controllers. | Coordinators can become imperative flow managers without testable product state. | Routes are typed outputs from the reducer. The app shell decides how to perform them. |
| VIPER | Clear module responsibilities, strong testability. | High ceremony and many files for every feature. | Files are role-based, but the minimum useful feature is still small. |
| VIP / Clean Swift | Clean request-response cycle. | Can feel scene-heavy and less natural for async, retry, offline, or long-running flows. | State machine shape makes long workflows explicit. |
| Clean Architecture | Dependency Rule keeps domain independent. | Mobile teams often cargo-cult layers and create repositories/use cases for simple UI flows. | Dependency direction is preserved through capabilities/effects without mandatory layers. |
| Redux / Elm / MVI / UDF | State is explicit and transitions are testable. | Side effects, cancellation, navigation, and lifecycle often need extra conventions. | Effects, effect IDs, routes, and outputs are first-class. |
| TCA | Excellent state/action/reducer/effect/testing design. | Strong framework commitment and learning curve. | IntentFlow is smaller and framework-light, with optional AI manifest support. |
| RIBs | Scales nested workflows for very large teams. | Heavy adoption cost for normal product teams. | Parent-child workflow thinking is encouraged without adopting a large framework. |
| AI rulesets | Let AI tools follow project style. | Rules are often prose beside the code, not behavior contracts. | AI mode uses manifest invariants and traces as the generation contract. |

## Repeated Complaints

Across patterns, the recurring complaints are surprisingly consistent:

- too much boilerplate for simple features
- too little structure for complex async behavior
- navigation is either hidden in UI or centralized in a large coordinator
- side effects are not typed or cancellable
- error/retry/offline states are afterthoughts
- testability depends on discipline instead of architectural shape
- AI tools can generate code that follows file names but violates behavior

IntentFlow responds by making feature behavior a reducer-owned state machine with explicit effects, outputs, routes, and invariants.
