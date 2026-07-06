# Generator

IntentFlow includes a small generator CLI.

## Generate Core Feature

```bash
swift run intentflow feature Profile --mode core --ui none --output ./Sources/Features
```

## Generate AI Feature

```bash
swift run intentflow feature Checkout --mode ai --ui swiftui --output ./Sources/Features
```

## Validate Manifest

```bash
swift run intentflow validate .intentflow/login.intentflow.yaml
```

## Generate AI Context

```bash
swift run intentflow ai-context .intentflow/login.intentflow.yaml --tool codex
swift run intentflow ai-context .intentflow/login.intentflow.yaml --tool claude
swift run intentflow ai-context .intentflow/login.intentflow.yaml --tool gemini
swift run intentflow ai-context .intentflow/login.intentflow.yaml --tool copilot
```

The context output is a compact Markdown handoff for coding agents. It includes the manifest contract, invariants, acceptance traces, provider-specific instruction files, and verification commands.

## Output

```text
Checkout/
  CheckoutContract.swift
  CheckoutFlow.swift
  CheckoutEffects.swift
  CheckoutProjection.swift
  CheckoutFlowTests.swift
  Checkout.intentflow.yaml
```

## Philosophy

The generator intentionally creates a starting point, not a finished product.

It should:

- create the architectural skeleton
- include a reducer test
- include explicit loading and failure states
- include cancellation ID usage
- include AI manifest when requested
- produce compact AI context from a manifest

It should not:

- invent domain decisions silently
- hide side effects in UI
- generate a huge module the user cannot understand
