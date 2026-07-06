#!/usr/bin/env bash
set -euo pipefail

swift test
swift run intentflow-generate feature SmokeFeature --mode ai --ui none --output /tmp/intentflow-smoke
