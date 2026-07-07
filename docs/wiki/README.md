# Versioned Wiki Source

This directory is the versioned source for the public IntentFlow wiki.

GitHub stores Wiki pages in a separate repository named:

```text
https://github.com/emrecanozturk/intentflow-ios.wiki.git
```

GitHub creates that repository only after the first page is created from the Wiki tab. Until then, this directory keeps the full wiki reviewable, testable, and versioned in the main repository.

After the Wiki tab has one Home page, publish this directory with:

```bash
./scripts/publish-wiki.sh
```

Files beginning with `_`, such as `_Sidebar.md` and `_Footer.md`, are GitHub Wiki special pages.
