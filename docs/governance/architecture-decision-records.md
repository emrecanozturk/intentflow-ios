# Architecture Decision Records

IntentFlow uses lightweight architecture decision records for significant changes.

## ADR Template

```markdown
# ADR: Title

## Status

Proposed | Accepted | Rejected | Superseded

## Context

What workflow or adoption pressure exists?

## Decision

What are we changing?

## Consequences

What gets simpler?
What gets harder?
What remains unresolved?
```

## Accepted Decisions

### ADR-001: Split Intent and Event

User input and external results are separate types.

Why:

- UI adapters send intents.
- Effect handlers return events.
- Tests can distinguish user behavior from outside-world response.

### ADR-002: Route and Output Are Separate

Navigation and parent communication are not the same thing.

Why:

- A route changes UI location.
- An output tells a parent/app shell that product behavior happened.
- Mixing them recreates hidden callback architecture.

### ADR-003: AI Mode Uses a Manifest

AI support is not a prose prompt only.

Why:

- AI needs bounded state/action/effect vocabulary.
- Invariants need to be visible.
- Acceptance traces should guide code and tests.
