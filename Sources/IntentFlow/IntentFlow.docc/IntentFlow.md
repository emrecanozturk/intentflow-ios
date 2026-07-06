# ``IntentFlow``

Model iOS features as explicit workflows.

## Overview

IntentFlow is a workflow-first architecture for SwiftUI and UIKit.

At the center is a pure reducer:

```text
State + Intent/Event -> Next State + Effects + Outputs + Routes
```

Use IntentFlow when a feature has:

- async work
- cancellation
- retry
- navigation
- parent communication
- permission or error recovery
- AI-assisted code generation requirements

## Topics

### Runtime

- ``FlowReducer``
- ``FlowStore``
- ``FlowEffectHandler``
- ``Next``
- ``EffectRequest``
- ``EffectID``
- ``EffectPolicy``

### UI

- ``FlowProjection``
- ``FlowObservation``

### Testing

- ``FlowTrace``
- ``FlowTraceStep``
