# IntentFlow for iOS Wiki

IntentFlow is a workflow-first, AI-ready architecture for iOS apps. It treats product behavior as the primary artifact:

```text
State + Intent/Event -> Next State + Effects + Outputs + Routes
```

The project is not trying to replace every iOS pattern. It is designed for the place where MVC, MVVM, Coordinators, VIPER, Clean Architecture, TCA, and RIBs often become unclear: async workflows, side effects, cancellation, navigation, recovery, parent communication, observability, and AI-assisted code generation.

## Start Here

| Goal | Page |
|---|---|
| Try the project quickly | [Start Here](Start-Here) |
| Learn the vocabulary | [Core Concepts](Core-Concepts) |
| Decide whether to use AI mode | [Core vs AI](Core-vs-AI) |
| Understand why the architecture exists | [Design Principles](Design-Principles) |
| Integrate it into an app | [API and Integration Guide](API-and-Integration-Guide) |
| Generate and validate features | [Generator and Manifests](Generator-and-Manifests) |
| Use Codex, Claude, Gemini, Copilot, or Cursor | [AI Agent Playbook](AI-Agent-Playbook) |
| Migrate from existing patterns | [Migration Playbook](Migration-Playbook) |
| Check release and security quality | [Operational Readiness](Operational-Readiness) |

## Public Status

IntentFlow is currently a `0.1.x` architecture proposal. The package builds, tests, includes examples, ships a generator and validator, and has CI, documentation checks, CodeQL scanning, security reporting, release notes, and contribution templates.

The recommended adoption path is to try it on one real feature before standardizing an entire app around it.

## Architecture At A Glance

| Piece | Responsibility |
|---|---|
| `State` | What product behavior is currently happening. |
| `Intent` | What the user, UI, or adapter asks for. |
| `Event` | What the outside world reports back. |
| `Effect` | Typed request for side work. |
| `Output` | Typed parent communication. |
| `Route` | Typed navigation request. |
| `FlowReducer` | Pure transition function. |
| `FlowStore` | Runtime boundary for state, effects, observers, routes, and outputs. |
| `Projection` | UI-friendly view state derived from feature state. |

## Repository Map

```text
Sources/IntentFlow              Core runtime
Sources/IntentFlowAI            Manifest parsing and validation
Sources/IntentFlowGenerate      Generator and AI context command
Examples/SwiftUIExample         SwiftUI adapter example
Examples/UIKitExample           UIKit adapter example
Examples/Migration              MVC/MVVM migration examples
docs/                           Long-form documentation
docs/wiki/                      Versioned wiki source
.intentflow/                    Example manifests and prompts
.github/                        CI, CodeQL, templates, Copilot instructions
```

## What This Wiki Covers

| Page | Use It For |
|---|---|
| [Start Here](Start-Here) | The fastest path from clone to first generated feature. |
| [Core Concepts](Core-Concepts) | The vocabulary: state, intent, event, effect, output, route, projection, store. |
| [Core vs AI](Core-vs-AI) | Choosing the human-first or AI-assisted variant. |
| [Design Principles](Design-Principles) | The problem definition, decision rules, and non-goals behind the architecture. |
| [Architecture Lifecycle](Architecture-Lifecycle) | How a feature moves from product behavior to UI, effects, tests, and release. |
| [API and Integration Guide](API-and-Integration-Guide) | How to wire reducers, stores, effects, projections, SwiftUI, and UIKit. |
| [Generator and Manifests](Generator-and-Manifests) | CLI usage, generated files, manifests, validation, and context output. |
| [AI Agent Playbook](AI-Agent-Playbook) | Codex, Claude, Gemini, Copilot, Cursor, and token budgeting. |
| [Examples and Recipes](Examples-and-Recipes) | SwiftUI, UIKit, migration examples, and common workflow recipes. |
| [Migration Playbook](Migration-Playbook) | Moving from MVC, MVVM, VIPER, Clean, TCA, RIBs, and Coordinators. |
| [Testing and Quality](Testing-and-Quality) | Reducer tests, store tests, manifest validation, CI, CodeQL, and release checks. |
| [Operational Readiness](Operational-Readiness) | Release, security, documentation, and maintenance expectations. |
| [Troubleshooting](Troubleshooting) | Common adoption, generator, async, and AI issues. |
| [Contributing and Governance](Contributing-and-Governance) | How proposals, PRs, issues, releases, and decisions should work. |
| [FAQ](FAQ) | Short answers for common questions. |

## The Core Promise

IntentFlow should make features easier to:

- understand from a state diagram
- test without UI
- review without hidden side effects
- migrate feature by feature
- generate with AI without architectural drift
- explain to new contributors

## Start

Clone and verify:

```bash
git clone https://github.com/emrecanozturk/intentflow-ios.git
cd intentflow-ios
swift test
swift run intentflow validate .intentflow/login.intentflow.yaml
```

Generate a feature:

```bash
swift run intentflow feature Checkout --mode ai --ui swiftui --output /tmp/intentflow-demo
```

## Suggested Reading Paths

New adopters: [Start Here](Start-Here) -> [Core Concepts](Core-Concepts) -> [Examples and Recipes](Examples-and-Recipes)

Architecture reviewers: [Design Principles](Design-Principles) -> [Architecture Lifecycle](Architecture-Lifecycle) -> [Migration Playbook](Migration-Playbook)

AI-assisted teams: [Core vs AI](Core-vs-AI) -> [Generator and Manifests](Generator-and-Manifests) -> [AI Agent Playbook](AI-Agent-Playbook)

Maintainers: [Testing and Quality](Testing-and-Quality) -> [Operational Readiness](Operational-Readiness) -> [Contributing and Governance](Contributing-and-Governance)
