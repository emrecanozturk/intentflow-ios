# Operational Readiness

This page describes what "ready to share publicly" means for IntentFlow.

## Current Readiness

IntentFlow currently includes:

- Swift package targets for runtime, AI manifest support, and generator support
- SwiftUI, UIKit, demo app, and migration examples
- generator and manifest validator
- AI context output for multiple coding agents
- CI for package tests, generator smoke checks, manifest validation, and demo app build
- DocC build check
- CodeQL Swift scanning
- security policy
- issue templates, contribution guide, code of conduct, and roadmap

The project is still a `0.1.x` architecture proposal. It should be evaluated on one real feature before organization-wide adoption.

## Quality Gates

Run locally before release-facing changes:

```bash
./scripts/check.sh
```

That check covers:

- package build
- Swift tests
- generator smoke tests
- manifest validation
- demo app build
- DocC build

GitHub Actions covers:

- CI
- Documentation
- CodeQL
- Release Check
- Dependabot

## CodeQL Coverage

Swift CodeQL only scans files that are part of a build. The repository uses a manual CodeQL build that compiles:

- Swift package sources
- test targets
- demo app target
- SwiftUI example sources
- UIKit example sources
- migration example sources
- DocC tutorial Swift sample

The current CodeQL run scans all Swift files in the repository.

## Security Posture

The repository should keep:

- `SECURITY.md` current
- private vulnerability reporting enabled
- secret scanning enabled
- Dependabot alerts enabled
- CodeQL enabled
- no fake advisories
- no committed tokens, local secrets, or non-public project material

Security advisories should be created only for real vulnerabilities.

## Documentation Bar

Public docs should answer:

- what IntentFlow is
- when to use it
- when not to use it
- how Core differs from AI mode
- how to generate a feature
- how to wire SwiftUI and UIKit
- how to migrate from existing patterns
- how to test behavior
- how to use AI tools safely
- how to report issues or contribute

If a user needs to infer an architectural rule from source code alone, the docs are incomplete.

## Release Bar

Before publishing a release:

- run `./scripts/check.sh`
- verify GitHub Actions are green
- verify release notes explain behavior impact
- update docs for public guidance changes
- update manifests if generated contract shape changes
- verify examples still build
- verify CodeQL is green

## Public Communication Bar

Public launch copy should be accurate:

- say "workflow-first" and "AI-ready"
- avoid claiming to be a universal replacement for every architecture
- be clear that this is a `0.1.x` proposal
- invite feedback from real feature adoption
- link to examples, migration guide, and AI playbook

## Maintainer Checklist

When reviewing an issue or PR, ask:

- does this improve behavior clarity?
- does it preserve reducer purity?
- does it keep effects explicit?
- does it make routes or outputs more testable?
- does it reduce AI drift?
- does it add ceremony without a clear benefit?
- does it require docs or migration notes?
