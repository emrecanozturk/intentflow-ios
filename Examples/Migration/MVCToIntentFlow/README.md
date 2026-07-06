# MVC to IntentFlow

MVC can stay useful when view controllers are adapters instead of workflow owners.

## Before

The controller owns loading, callbacks, navigation, and rendering.

## After

The controller sends intents and renders projected state. The flow owns product behavior.

This migration can happen screen by screen without a full rewrite.
