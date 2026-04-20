---
name: update-microsoft-365-beta-json
description: Workflow command scaffold for update-microsoft-365-beta-json in Scoop-App-Versions.
allowed_tools: ["Bash", "Read", "Write", "Grep", "Glob"]
---

# /update-microsoft-365-beta-json

Use this workflow when working on **update-microsoft-365-beta-json** in `Scoop-App-Versions`.

## Goal

Updates the version of Microsoft 365 beta suite manifests (multiple similarly named JSON files) to reflect new preview or beta releases.

## Common Files

- `bucket/microsoft-365-access-excel-power-point-word-visio-project-beta.json`
- `bucket/microsoft-365-access-excel-one-drive-outlook-power-point-teams-word-visio-project-beta.json`

## Suggested Sequence

1. Understand the current state and failure mode before editing.
2. Make the smallest coherent change that satisfies the workflow goal.
3. Run the most relevant verification for touched files.
4. Summarize what changed and what still needs review.

## Typical Commit Signals

- Detect new beta/preview version for Microsoft 365 suite.
- Edit the relevant 'bucket/microsoft-365-*.json' file(s) to update the version.
- Commit with a message specifying the suite and version.

## Notes

- Treat this as a scaffold, not a hard-coded script.
- Update the command if the workflow evolves materially.