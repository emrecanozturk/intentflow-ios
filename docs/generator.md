# Generator

IntentFlow includes a small generator CLI.

## Generate Core Feature

```bash
swift run intentflow-generate feature Profile --mode core --ui none --output ./Sources/Features
```

## Generate AI Feature

```bash
swift run intentflow-generate feature Checkout --mode ai --ui swiftui --output ./Sources/Features
```

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

It should not:

- invent domain decisions silently
- hide side effects in UI
- generate a huge module the user cannot understand
