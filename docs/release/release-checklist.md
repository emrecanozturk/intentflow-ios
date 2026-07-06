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
git tag 0.1.0
git push origin main --tags
```

## Recommended GitHub Release Notes

```markdown
IntentFlow 0.1.0 introduces a workflow-first iOS architecture with:

- Core runtime
- AI manifest mode
- Generator and validator CLI
- SwiftUI and UIKit examples
- Migration guides
- Pattern research matrix
```
