# Quick Start

This guide gets you from clone to generated AI-mode feature.

## Clone

```bash
git clone https://github.com/emrecanozturk/intentflow-ios.git
cd intentflow-ios
```

## Verify

```bash
swift test
swift run intentflow validate .intentflow/login.intentflow.yaml
```

## Generate A Feature

```bash
swift run intentflow feature Checkout --mode ai --ui swiftui --output /tmp/intentflow-demo
```

Generated files:

```text
/tmp/intentflow-demo/Checkout/
  CheckoutContract.swift
  CheckoutFlow.swift
  CheckoutEffects.swift
  CheckoutProjection.swift
  CheckoutFlowTests.swift
  Checkout.intentflow.yaml
```

## Generate Agent Context

```bash
swift run intentflow ai-context /tmp/intentflow-demo/Checkout/Checkout.intentflow.yaml --tool codex
```

Use the output as the handoff to Codex, Claude, Gemini, Copilot, Cursor, or another coding agent.

## First Real Feature Checklist

- Write the states before the UI.
- Add intents for user actions.
- Add events for effect results.
- Add effects for async work.
- Add routes for navigation.
- Add outputs for parent communication.
- Add invariants for rules that must never break.
- Add acceptance traces for the important paths.
- Add reducer tests before connecting the UI.
