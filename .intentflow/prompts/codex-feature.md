# Codex Feature Prompt

Use this when asking Codex to create or modify an IntentFlow AI feature.

```text
Read AGENTS.md, .ai/agent-context.md, and the feature manifest first.
Use:
swift run intentflow ai-context <manifest-path> --tool codex

Task:
<describe the feature behavior>

Rules:
- Update the manifest before changing Swift contracts.
- Keep reducers pure.
- Put async work in FlowEffectHandler.
- Add reducer trace tests for every new branch.
- Run swift test and manifest validation.
```
