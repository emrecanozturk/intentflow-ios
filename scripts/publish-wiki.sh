#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WIKI_SOURCE="$ROOT_DIR/docs/wiki"
WIKI_REMOTE="${WIKI_REMOTE:-https://github.com/emrecanozturk/intentflow-ios.wiki.git}"
WORK_DIR="${TMPDIR:-/tmp}/intentflow-ios.wiki"

if [ ! -d "$WIKI_SOURCE" ]; then
  echo "Missing wiki source: $WIKI_SOURCE" >&2
  exit 1
fi

if ! git ls-remote "$WIKI_REMOTE" HEAD >/dev/null 2>&1; then
  cat >&2 <<EOF
GitHub has not created the wiki repository yet:
  $WIKI_REMOTE

Create the first Home page once from the GitHub Wiki tab, then run this script again.
EOF
  exit 1
fi

rm -rf "$WORK_DIR"
git clone "$WIKI_REMOTE" "$WORK_DIR"

rsync -a --delete --exclude ".git/" --exclude "README.md" "$WIKI_SOURCE/" "$WORK_DIR/"

cd "$WORK_DIR"
if git diff --quiet && git diff --cached --quiet && [ -z "$(git status --short)" ]; then
  echo "Wiki is already up to date."
  exit 0
fi

git add -A
git commit -m "Update IntentFlow wiki"
git push origin HEAD

echo "Wiki published: $WIKI_REMOTE"
