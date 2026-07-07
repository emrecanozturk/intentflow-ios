# Generator and Manifests

IntentFlow includes a small CLI generator. It creates a starting point, not a finished product.

## Generate Core

```bash
swift run intentflow feature Profile --mode core --ui none --output ./Sources/Features
```

## Generate AI

```bash
swift run intentflow feature Checkout --mode ai --ui swiftui --output ./Sources/Features
```

## Generated Files

```text
Checkout/
  CheckoutContract.swift
  CheckoutFlow.swift
  CheckoutEffects.swift
  CheckoutProjection.swift
  CheckoutFlowTests.swift
  Checkout.intentflow.yaml
```

The manifest is generated only in AI mode.

## Manifest Shape

```yaml
schemaVersion: "0.1"
feature: "Checkout"
mode: "ai"
summary: "Collect payment and complete an order."
states:
  - idle
  - validatingCart
  - authorizingPayment
  - failed(message)
  - completed(orderID)
intents:
  - start
  - retry
  - cancel
events:
  - cartValid
  - paymentAuthorized(orderID)
  - failed(message)
effects:
  - validateCart
  - authorizePayment
routes:
  - paymentSheet
outputs:
  - orderCompleted(orderID)
invariants:
  - "Payment authorization can only start after cart validation succeeds."
acceptanceTraces:
  - "idle + start -> validatingCart + validateCart effect"
```

## Validate

```bash
swift run intentflow validate .intentflow/login.intentflow.yaml
```

Validation checks required manifest structure and AI-mode expectations.

## Generate AI Context

```bash
swift run intentflow ai-context .intentflow/login.intentflow.yaml --tool codex
swift run intentflow ai-context .intentflow/login.intentflow.yaml --tool claude
swift run intentflow ai-context .intentflow/login.intentflow.yaml --tool gemini
swift run intentflow ai-context .intentflow/login.intentflow.yaml --tool copilot
```

The output is a compact handoff for coding agents. It includes:

- feature summary
- states, intents, events, effects, routes, outputs
- invariants
- acceptance traces
- provider-specific files to read
- verification commands

## Generator Philosophy

The generator should:

- create the architectural skeleton
- make behavior visible
- include tests
- include cancellation IDs where useful
- include a manifest in AI mode
- keep output understandable

The generator should not:

- invent business decisions silently
- hide side effects in UI
- generate huge modules
- replace human review

## When To Edit The Manifest

Update the manifest when you add, remove, or rename:

- state
- intent
- event
- effect
- route
- output
- invariant
- acceptance trace

AI-generated changes should update manifest and tests together.
