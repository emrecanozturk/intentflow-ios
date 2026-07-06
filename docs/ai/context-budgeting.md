# Context Budgeting

AI mode should reduce context load, not increase it. The repository is structured so agents can work from a small contract first and only open implementation files when needed.

## Budget Order

Use this order for feature work:

1. `.ai/agent-context.md`
2. the relevant `.intentflow.yaml` manifest
3. `swift run intentflow ai-context <manifest> --tool <tool>`
4. matching contract, reducer, effect handler, projection, and tests
5. docs only when behavior or public guidance changes

Do not start by reading the whole repository.

## What To Exclude

Agents should normally skip:

- `.git`
- `.build`
- `DerivedData`
- Xcode user state
- screenshots and recordings
- generated project internals unless the task touches the demo app project
- historical release notes unless the task is release-specific

## Token-Saving Rules

- Prefer manifests and acceptance traces over long prose prompts.
- Ask for one workflow change per agent run.
- Keep generated context focused on feature behavior.
- Use path-scoped rules for Swift and docs instead of one huge instruction file.
- Update tests and manifests together so later agents do not have to infer intent from code.
- Use `intentflow ai-context` as the handoff artifact between tools.

## Example Handoff

```bash
swift run intentflow ai-context .intentflow/login.intentflow.yaml --tool codex > /tmp/login-context.md
```

Then paste or attach `/tmp/login-context.md` to the agent alongside a small task:

```text
Add a locked-out state after three failed token attempts.
Update manifest, reducer, effects if needed, projection, and tests.
```

## Review Checklist

- Did the agent read the manifest first?
- Did the change keep reducers pure?
- Did the change add or update acceptance traces?
- Did tests cover success, failure, retry, cancellation, and route/output behavior where relevant?
- Did docs stay aligned with current package and CLI commands?
