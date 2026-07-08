# Support

IntentFlow is an experimental iOS architecture proposal. The fastest way to get useful help is to describe the workflow you are trying to model.

## Best Channels

- Adoption questions: use GitHub Discussions Q&A when you want modeling help, or the "Adoption Question" issue template when the request is specific and actionable.
- Architecture proposals: start in Discussions Ideas when the shape is still forming; use the "Architecture Discussion" issue template when the proposal is ready to track.
- AI generation feedback: use the "AI Generation Feedback" issue template when a tool drifted from a manifest, prompt, or rule.
- Bugs in the package, examples, generator, or docs: use the "Bug Report" issue template.
- Security concerns: follow `SECURITY.md` and report privately.

## What To Include

For architecture and adoption questions, include:

- current pattern: MVC, MVVM, VIPER, Clean, TCA, RIBs, or other
- states the feature can be in
- user intents
- async results or external events
- side effects such as network, persistence, analytics, permissions, or timers
- routes and parent outputs
- what is currently hard to test or generate safely

## Before Asking

Useful starting points:

- `README.md`
- `COMMUNITY.md`
- `docs/wiki/Home.md`
- `docs/wiki/Community.md`
- `docs/adoption/quick-start.md`
- `docs/migration/migration-guide.md`
- `docs/faq.md`
- `docs/ai/agent-usage.md`

## Maintainer Scope

The project can help with the IntentFlow architecture, package behavior, generator output, examples, and documentation. It cannot review private production code unless you provide a minimal public reproduction.
