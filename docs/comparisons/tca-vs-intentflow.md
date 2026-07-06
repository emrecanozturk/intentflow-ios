# TCA vs IntentFlow

IntentFlow is influenced by reducer-based architectures, including TCA.

## Similarities

- State is explicit.
- Transitions are testable.
- Effects are separated from pure behavior.
- UI observes state and sends actions/intents.

## Differences

| Concern | TCA | IntentFlow |
|---|---|---|
| Input type | Action | Intent and Event split |
| Navigation | TCA navigation tools | Route output |
| Parent communication | Actions/delegation patterns | Output |
| Dependencies | Dependency system | App-owned capabilities/effect handlers |
| AI support | Project-specific instructions | Manifest, invariants, acceptance traces, rules |
| Adoption | Framework | Small runtime and contracts |

Use TCA if you want a mature, comprehensive ecosystem.

Use IntentFlow if you want a smaller workflow contract, explicit AI mode, and lower framework commitment.
