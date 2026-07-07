# Testing and Quality

IntentFlow is useful only if behavior becomes easier to verify.

## Local Checks

Run the fast checks:

```bash
swift test
swift run intentflow validate .intentflow/login.intentflow.yaml
```

Run the full release-facing check:

```bash
./scripts/check.sh
```

## What The Full Check Covers

- Swift package build
- Swift tests
- generator smoke tests
- AI manifest validation
- demo app build
- DocC build

## CI

GitHub Actions currently includes:

- CI: package tests, generator smoke, manifest validation, demo app build
- Documentation: DocC build
- CodeQL: Swift code scanning
- Release Check: release readiness workflow
- Dependabot: Swift and GitHub Actions dependency checks

## Reducer Tests

Reducer tests should read like acceptance traces:

```text
idle + submit -> validating + validate effect
validating + credentialsValid -> requestingToken + requestToken effect
requestingToken + tokenReceived -> authenticated + completed output
```

## Store Tests

Store tests should cover:

- effect handlers feeding events back into the store
- observation snapshots
- route emission
- output emission
- cancellation behavior

## Manifest Tests

AI-mode features should validate:

- required fields exist
- invariants are present
- acceptance traces are present
- mode-specific files are generated

## Code Review Checklist

Before merging:

- reducers are pure
- effects are typed
- long-running effects have cancellation IDs
- UI remains an adapter
- routes and outputs are explicit
- tests cover new workflow branches
- manifests and docs are updated when contracts change

## Security And Quality

The public repository is configured with:

- security policy
- private vulnerability reporting
- Dependabot alerts and security updates
- secret scanning and push protection
- CodeQL code scanning

Do not publish fake security advisories. Advisories should exist only for real vulnerabilities.
