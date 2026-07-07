# Troubleshooting

## The State List Feels Too Big

Check whether some items are UI projection details.

Use state for product behavior:

```text
uploading(progress)
failed(message)
completed(remoteID)
```

Use projection for display details:

```text
isButtonEnabled
spinnerVisible
titleText
```

## The Reducer Wants To Call A Service

Stop and create an effect.

Reducers request work. Effect handlers execute work.

## Navigation Is Still In The View

Route decisions should be emitted by the reducer:

```text
state + event -> next state + route
```

The UI or coordinator interprets the route.

## Parent Communication Is Hidden In Closures

Use `Output`.

Outputs make parent communication testable and reviewable.

## AI Generated Code Drifts From The Contract

Use AI mode:

```bash
swift run intentflow ai-context .intentflow/login.intentflow.yaml --tool codex
```

Then ask the agent to update manifest, Swift types, reducer, projection, and tests together.

## Manifest Validation Fails

Check:

- `schemaVersion`
- `feature`
- `mode`
- non-empty states, intents, effects, invariants, and acceptance traces for AI mode
- indentation
- quoted values when text contains punctuation

## Generated Feature Does Not Match Your Domain

The generator creates a skeleton. Rename states, effects, and routes before integrating deeply.

Do not keep placeholder domain names just because the generator produced them.

## CodeQL Takes Longer Than CI

Swift CodeQL builds can take longer because CodeQL extracts a database while building. This is expected. The workflow uses a manual Swift build that includes package sources, tests, demo app code, examples, migration samples, and the DocC tutorial Swift sample so the visible CodeQL coverage matches the repository.

## The GitHub Wiki Tab Is Empty

The versioned wiki source lives in:

```text
docs/wiki
```

GitHub stores the visible Wiki tab in a separate `.wiki.git` repository. GitHub creates that repository only after the first Wiki page is created from the browser. After that, run:

```bash
./scripts/publish-wiki.sh
```
