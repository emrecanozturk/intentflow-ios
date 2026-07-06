# Release Checklist

Use this checklist before publishing a tag.

## Required

- [ ] `scripts/check.sh` passes locally.
- [ ] `CHANGELOG.md` includes the release version.
- [ ] README installation URL points to the public repository.
- [ ] CI passes on `main`.
- [ ] DocC builds.
- [ ] Generator smoke test passes.
- [ ] Manifest validation passes.
- [ ] Examples compile or are marked as source-only examples.
- [ ] No secrets, local paths, or private URLs are committed.

## Tag

```bash
git tag <version>
git push origin main --tags
```

## Recommended GitHub Release Notes

```markdown
IntentFlow <version> introduces a workflow-first iOS architecture with:

- Core runtime
- AI manifest mode
- Generator, validator, and AI context CLI
- SwiftUI and UIKit examples
- Migration guides
- Pattern research matrix
```
