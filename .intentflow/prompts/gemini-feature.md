# Gemini Feature Prompt

Use this when asking Gemini CLI for planning, generation, or review.

```text
Read GEMINI.md and .ai/agent-context.md.
Use this compact feature context:
swift run intentflow ai-context <manifest-path> --tool gemini

Task:
<describe the workflow change>

Only inspect files needed for the manifest, contract, reducer, effects, projection, and tests.
```
