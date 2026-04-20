---
name: update-app-version-json
description: Workflow command scaffold for update-app-version-json in Scoop-App-Versions.
allowed_tools: ["Bash", "Read", "Write", "Grep", "Glob"]
---

# /update-app-version-json

Use this workflow when working on **update-app-version-json** in `Scoop-App-Versions`.

## Goal

Updates the version of a specific application in its corresponding JSON manifest file under the 'bucket/' directory.

## Common Files

- `bucket/*.json`

## Suggested Sequence

1. Understand the current state and failure mode before editing.
2. Make the smallest coherent change that satisfies the workflow goal.
3. Run the most relevant verification for touched files.
4. Summarize what changed and what still needs review.

## Typical Commit Signals

- Identify the application to update.
- Edit the corresponding 'bucket/{app-name}.json' file to update the version and possibly the download URL/hash.
- Commit the change with a message indicating the app and new version.

## Notes

- Treat this as a scaffold, not a hard-coded script.
- Update the command if the workflow evolves materially.