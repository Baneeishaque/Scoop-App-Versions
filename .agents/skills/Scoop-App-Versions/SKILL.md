```markdown
# Scoop-App-Versions Development Patterns

> Auto-generated skill from repository analysis

## Overview
This skill teaches you how to contribute to the `Scoop-App-Versions` repository, which manages JSON manifests for various Windows applications in a Scoop bucket. You'll learn the coding conventions, file organization, and step-by-step workflows for updating app versions, nightly builds, Microsoft 365 beta releases, and Discord installers. The guide also covers commit message patterns, testing file conventions, and provides ready-to-use commands for common tasks.

## Coding Conventions

- **File Naming:**  
  All files use `kebab-case`.  
  _Example:_  
  ```
  bucket/gradle-nightly.json
  bucket/microsoft-365-access-excel-power-point-word-visio-project-beta.json
  ```

- **Import Style:**  
  Use relative imports in TypeScript files.  
  _Example:_  
  ```typescript
  import { updateVersion } from './utils/update-version';
  ```

- **Export Style:**  
  Use named exports.  
  _Example:_  
  ```typescript
  export function updateVersion() { ... }
  ```

- **Commit Messages:**  
  Freeform, typically indicate the app and new version.  
  _Example:_  
  ```
  Update gradle-nightly to 7.3.0-20211026000000+0000
  ```

## Workflows

### Update App Version JSON
**Trigger:** When a new version of an application is released and needs to be reflected in the Scoop bucket.  
**Command:** `/update-version app-name new-version`

1. Identify the application to update.
2. Edit the corresponding `bucket/{app-name}.json` file:
   - Update the `"version"` field.
   - Update the `"url"` and `"hash"` fields if necessary.
3. Commit the change with a message indicating the app and new version.

_Example:_  
```json
{
  "version": "2.5.1",
  "url": "https://example.com/app-2.5.1.zip",
  "hash": "sha256:abcd1234..."
}
```
_Commit message:_  
```
Update example-app to 2.5.1
```

---

### Update Nightly Build JSON
**Trigger:** When a new nightly/daily build is available for an application tracked in the bucket.  
**Command:** `/update-nightly app-name new-version`

1. Check for a new nightly/daily build version.
2. Edit the corresponding `bucket/{nightly-app}.json` file:
   - Update the `"version"` field.
   - Update the `"url"` and `"hash"` fields as needed.
3. Commit with a message indicating the app and new build version.

_Example:_  
```json
{
  "version": "7.3.0-20211026",
  "url": "https://example.com/gradle-nightly-7.3.0-20211026.zip",
  "hash": "sha256:efgh5678..."
}
```
_Commit message:_  
```
Update gradle-nightly to 7.3.0-20211026
```

---

### Update Microsoft 365 Beta JSON
**Trigger:** When Microsoft releases a new beta/preview version for its 365 suite.  
**Command:** `/update-m365-beta suite-name new-version`

1. Detect the new beta/preview version for the Microsoft 365 suite.
2. Edit the relevant `bucket/microsoft-365-*.json` file(s):
   - Update the `"version"` field.
   - Update `"url"` and `"hash"` as needed.
3. Commit with a message specifying the suite and version.

_Example:_  
```json
{
  "version": "16.0.12345.20000",
  "url": "https://example.com/m365-beta-16.0.12345.20000.exe",
  "hash": "sha256:ijkl9012..."
}
```
_Commit message:_  
```
Update microsoft-365-access-excel-power-point-word-visio-project-beta to 16.0.12345.20000
```

---

### Update Discord Installer JSON
**Trigger:** When a new version of a Discord installer (canary, ptb) is released.  
**Command:** `/update-discord-installer channel new-version`

1. Check for the new Discord installer version.
2. Edit the corresponding `bucket/discord-*-installer.json` file:
   - Update the `"version"` field.
   - Update `"url"` and `"hash"` if necessary.
3. Commit with a message indicating the installer and version.

_Example:_  
```json
{
  "version": "1.0.9001",
  "url": "https://discord.com/api/download/canary?platform=win",
  "hash": "sha256:mnop3456..."
}
```
_Commit message:_  
```
Update discord-canary-x64-installer to 1.0.9001
```

## Testing Patterns

- **Test Files:**  
  Test files use the pattern `*.test.*` (e.g., `update-version.test.ts`).
- **Framework:**  
  Not explicitly detected. Check for common frameworks like Jest or Mocha if you need to add or run tests.
- **Example:**  
  ```typescript
  // update-version.test.ts
  import { updateVersion } from './update-version';

  test('updates version correctly', () => {
    // test implementation
  });
  ```

## Commands

| Command                           | Purpose                                                      |
|------------------------------------|--------------------------------------------------------------|
| /update-version app-name new-version      | Update a standard app manifest to a new version              |
| /update-nightly app-name new-version      | Update a nightly/daily build manifest                        |
| /update-m365-beta suite-name new-version  | Update Microsoft 365 beta/preview manifest(s)                |
| /update-discord-installer channel new-version | Update a Discord installer manifest (canary, ptb, etc.)      |
```