# Contributing

IntentFlow contributions should improve clarity of product behavior.

## Before Opening a PR

Run:

```bash
swift test
```

## Pull Request Checklist

- The behavior change is represented in state, intent, event, effect, output, or route types.
- Reducers remain pure.
- Async work remains in effect handlers.
- Long-running effects have cancellation IDs.
- New workflow branches have tests.
- AI mode features update the manifest and rules if needed.
- Documentation is updated when the architecture contract changes.

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
