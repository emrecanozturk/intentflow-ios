#!/usr/bin/env bash
set -euo pipefail

swift test
swift run intentflow feature SmokeFeature --mode ai --ui none --output /tmp/intentflow-smoke
swift run intentflow validate .intentflow/login.intentflow.yaml
swift run intentflow ai-context .intentflow/login.intentflow.yaml --tool codex >/tmp/intentflow-ai-context.md
xcodebuild \
  -project Examples/IntentFlowDemoApp/IntentFlowDemoApp.xcodeproj \
  -scheme IntentFlowDemoApp \
  -destination 'generic/platform=iOS Simulator' \
  CODE_SIGNING_ALLOWED=NO \
  build
xcodebuild docbuild -scheme IntentFlow -destination 'generic/platform=macOS'
