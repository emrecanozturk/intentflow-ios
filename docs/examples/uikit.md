# UIKit Example Notes

The UIKit example models a file upload workflow.

It includes:

- document selection route
- prepare effect
- upload stream effect
- progress events
- pause
- retry
- cancellation
- completion output

The view controller remains imperative because UIKit is imperative. IntentFlow does not try to hide that. The important rule is that UIKit adapts to behavior; it does not own behavior.

Read the example: [UIKitExample](../../Examples/UIKitExample)
