## Summary

-

## IntentFlow Checklist

- [ ] Behavior is represented in state, intent, event, effect, route, or output types.
- [ ] Reducers remain pure.
- [ ] Long-running effects use cancellation IDs.
- [ ] UI remains an adapter.
- [ ] Transition tests cover new workflow branches.
- [ ] AI manifests and rules are updated when contracts change.

## Verification

```bash
swift test
swift run intentflow validate .intentflow/login.intentflow.yaml
```
