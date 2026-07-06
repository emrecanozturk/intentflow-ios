# IntentFlow Manifesto

Architecture is not folder structure.

Architecture is executable product behavior.

For years, iOS architecture discussions have mostly asked where code should live:

- controller
- view model
- presenter
- interactor
- use case
- repository
- coordinator

Those questions still matter, but they are no longer enough.

Modern apps are dominated by workflows:

- authentication with recovery
- checkout with retry
- upload with cancellation
- permissions with fallback
- offline sync
- device sessions
- long-running async work
- AI-assisted feature generation

These workflows are not naturally screen-shaped. When we force them into screen-shaped architecture, behavior becomes scattered.

IntentFlow starts with behavior.

Every feature says:

```text
These are my states.
These are the intents a user can send.
These are the events the outside world can return.
These are the effects I may request.
These are the routes I may emit.
These are the outputs my parent may observe.
```

Then UI adapts to that behavior.

This makes features easier to test, easier to review, easier to migrate, and safer for AI tools to modify.

The future of app architecture is not another name for ViewModel.

It is a contract humans and machines can both understand.
