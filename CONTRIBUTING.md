# Contributing

IntentFlow contributions should improve clarity of product behavior.

## Before Opening a PR

Run:

```bash
swift test
swift run intentflow validate .intentflow/login.intentflow.yaml
```

For release-facing changes, run:

```bash
./scripts/check.sh
```

## Good First Feedback

If you are trying IntentFlow for the first time, the most useful feedback is:

- a feature that mapped cleanly to states/intents/effects
- a feature that did not map cleanly
- an AI-generated change that ignored the manifest
- a migration pain from MVC, MVVM, Coordinators, VIPER, Clean, TCA, or RIBs

Use Discussions for open-ended adoption stories, modeling questions, and architecture ideas. Use issue templates when the feedback is specific enough to track as work.

## Discussions

Use GitHub Discussions when you want to:

- ask how to model a feature
- share an adoption story
- compare IntentFlow with another architecture in a concrete workflow
- propose an idea before it is ready for an issue
- ask for AI prompt or manifest guidance

Good discussions include states, intents, events, effects, routes, outputs, and what is currently hard to test or reason about.

## Pull Request Checklist

- The behavior change is represented in state, intent, event, effect, output, or route types.
- Reducers remain pure.
- Async work remains in effect handlers.
- Long-running effects have cancellation IDs.
- New workflow branches have tests.
- AI mode features update the manifest and rules if needed.
- Documentation is updated when the architecture contract changes.
- Launch-facing changes update the FAQ, quick start, launch kit, or release notes when relevant.

## Style

- Prefer small, explicit types over generic magic.
- Prefer exhaustive switches.
- Prefer value types for state and events.
- Avoid global singletons in examples.
- Keep examples realistic but readable.

## Design Bar

This repository should feel like a serious architecture proposal, not a toy sample.

New examples should show at least one real workflow pressure:

- retry
- cancellation
- permission
- offline/error state
- route output
- parent output
- progress
- long-running effect
