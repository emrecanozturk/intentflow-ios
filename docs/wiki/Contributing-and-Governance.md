# Contributing and Governance

IntentFlow contributions should improve clarity of product behavior.

## Contribution Types

Good contributions include:

- clearer reducer or store behavior
- better examples
- migration notes from real apps
- generator improvements
- manifest validation improvements
- AI rule improvements
- documentation that removes ambiguity
- tests for missing workflow branches

## Issue Types

Use:

- Bug Report for defects
- Feature Request for new runtime, generator, docs, or example work
- Adoption Question for modeling help
- Architecture Discussion for contract-level proposals
- AI Generation Feedback for agent behavior
- Documentation Feedback for unclear docs

## PR Bar

Every PR should answer:

- What behavior changed?
- Which state, intent, event, effect, output, or route changed?
- Are reducers still pure?
- Are effects still outside UI?
- Are routes and outputs explicit?
- Are tests updated?
- Are manifests updated when AI mode is involved?
- Are docs updated when public guidance changes?

## Design Decisions

Use `docs/governance/architecture-decision-records.md` for durable decisions.

Decision records should include:

- context
- decision
- alternatives
- consequences
- migration impact

## Release Readiness

Before release:

```bash
./scripts/check.sh
```

Release notes should explain:

- what changed
- why it changed
- migration impact
- AI/generator impact
- verification status

## Non-Goals

IntentFlow should not:

- become a large application framework
- replace every MVVM use case
- hide Swift concurrency behind magic
- generate business decisions without human review
- add ceremony that does not improve behavior clarity

## Maintainer Principle

Prefer explicit product behavior over clever abstraction.
