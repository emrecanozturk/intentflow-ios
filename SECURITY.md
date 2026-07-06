# Security Policy

IntentFlow is an architecture/runtime package. It should not contain secrets, telemetry endpoints, credentials, or production service tokens.

## Reporting

Please report security issues privately to the repository owner before opening a public issue.

## Scope

Security-sensitive areas include:

- effect cancellation or task lifetime leaks
- accidental persistence of sensitive state
- examples that teach unsafe token handling
- generated templates that encourage credentials in source

## Design Rule

Reducers must remain pure and must not read or write secrets directly. Sensitive work belongs behind explicit effect handlers and app-owned capabilities.
