# Community Guide

IntentFlow is a workflow-first architecture proposal for iOS. The community space should help people model real product behavior, compare architectural tradeoffs, and improve the project from actual adoption feedback.

## Where To Post

Use Discussions for open-ended conversation:

| Need | Use |
|---|---|
| Ask how to model a feature | [Q&A](https://github.com/emrecanozturk/intentflow-ios/discussions/categories/q-a) |
| Propose an architecture direction | [Ideas](https://github.com/emrecanozturk/intentflow-ios/discussions/categories/ideas) |
| Share an adoption story | [Show and tell](https://github.com/emrecanozturk/intentflow-ios/discussions/categories/show-and-tell) |
| Follow project updates | [Announcements](https://github.com/emrecanozturk/intentflow-ios/discussions/categories/announcements) |
| Discuss general project direction | [General](https://github.com/emrecanozturk/intentflow-ios/discussions/categories/general) |

Use Issues for actionable work:

| Need | Use |
|---|---|
| Report a reproducible defect | Bug Report |
| Request a concrete runtime, generator, docs, or example change | Feature Request |
| Report unclear documentation | Documentation Feedback |
| Report AI generation drift | AI Generation Feedback |

Use `SECURITY.md` for vulnerabilities. Do not report security issues in public Discussions or Issues.

## What Makes A Good Discussion

The best IntentFlow discussions include the workflow shape:

- current architecture or pattern
- states
- intents
- events
- effects
- routes
- outputs
- failure or recovery paths
- what is hard to test or reason about today

Example:

```text
Feature: upload with retry and cancellation
Current pattern: MVVM + Coordinator
States: idle, selectingFile, uploading(progress), failed(message), completed(remoteID)
Intents: selectFile, start, retry, cancel
Events: fileSelected, uploadProgress, uploadCompleted, uploadFailed
Effects: presentFilePicker, uploadFile
Routes: filePicker
Outputs: uploadCompleted(remoteID), cancelled
Friction: retry and cancellation are split between the ViewModel and coordinator
```

## Community Norms

- Be specific and technical.
- Prefer concrete workflow examples over abstract opinions.
- Compare tradeoffs respectfully.
- Ask for clarification before assuming intent.
- Keep AI output reviewable by showing prompts, manifests, and acceptance traces when relevant.
- Do not share private production code, tokens, credentials, or customer data.

## Maintainer Response Expectations

This is a small public project. Maintainer responses will prioritize:

1. reproducible bugs
2. adoption questions with concrete workflow shapes
3. generator or AI drift reports with manifests
4. documentation gaps that block adoption
5. broader architecture proposals

If a discussion becomes actionable, maintainers may ask for or create a focused issue.

## Good First Contributions

Useful first contributions include:

- a real migration note from MVC, MVVM, VIPER, Clean, Coordinators, TCA, or RIBs
- a small workflow example with tests
- documentation that clarifies a confusing concept
- generator feedback from a real feature
- AI rule improvements based on a concrete failed prompt
