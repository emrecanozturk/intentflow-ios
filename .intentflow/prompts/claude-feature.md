# Claude Feature Prompt

Use this when asking Claude Code to work on IntentFlow.

```text
Read CLAUDE.md, AGENTS.md, .ai/agent-context.md, and the feature manifest.
Generate compact context with:
swift run intentflow ai-context <manifest-path> --tool claude

Task:
<describe the workflow change>

Please keep the reducer pure, move async work into FlowEffectHandler, update tests, and avoid widening context beyond touched files.
```
