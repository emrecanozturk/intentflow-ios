# Claude Code Instructions

IntentFlow is contract-first. Read `AGENTS.md` for the shared repository rules, then use this file for Claude-specific context behavior.

## Claude Workflow

- Keep context small: start from `.ai/agent-context.md` and the relevant `.intentflow.yaml` manifest.
- Load Swift files only after the manifest and acceptance traces are clear.
- When editing `Sources/**`, `Tests/**`, or `Examples/**`, also follow `.claude/rules/intentflow-swift.md`.
- When editing Markdown or release material, also follow `.claude/rules/intentflow-docs.md`.
- Prefer a small plan, a focused patch, and local verification over broad rewrites.

## Required Checks

```bash
swift test
swift run intentflow validate .intentflow/login.intentflow.yaml
swift run intentflow ai-context .intentflow/login.intentflow.yaml --tool claude
```

Use `./scripts/check.sh` before release or when touching package, docs, examples, or workflows.
