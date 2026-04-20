---
name: update-nightly-build-json
description: Workflow command scaffold for update-nightly-build-json in Scoop-App-Versions.
allowed_tools: ["Bash", "Read", "Write", "Grep", "Glob"]
---

# /update-nightly-build-json

Use this workflow when working on **update-nightly-build-json** in `Scoop-App-Versions`.

## Goal

Updates the version of a nightly or daily build application in its JSON manifest (e.g., gradle-nightly, vlc-nightly-ucrt-llvm, netbeans-daily, element-nightly).

## Common Files

- `bucket/*nightly*.json`
- `bucket/*daily*.json`

## Suggested Sequence

1. Understand the current state and failure mode before editing.
2. Make the smallest coherent change that satisfies the workflow goal.
3. Run the most relevant verification for touched files.
4. Summarize what changed and what still needs review.

## Typical Commit Signals

- Check for new nightly/daily build version.
- Edit the corresponding 'bucket/{nightly-app}.json' file to reflect the new build version.
- Commit with a message indicating the app and new build version.

## Notes

- Treat this as a scaffold, not a hard-coded script.
- Update the command if the workflow evolves materially.