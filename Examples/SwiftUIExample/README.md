# SwiftUI Example: Device Connection Flow

This example models a device connection workflow as product behavior instead of screen-local state.

It demonstrates:

- explicit workflow states
- typed intents and events
- cancellable effects
- route/output separation
- SwiftUI observation without retaining the view model forever
- a projection layer that keeps SwiftUI rendering simple

The files are intentionally small enough to read in one pass, but the flow is realistic enough to show where MVVM view models usually start to grow too much.
