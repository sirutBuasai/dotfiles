---
description: Stage changes and write a Conventional Commits message from the diff
argument-hint: [optional scope or note]
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git diff:*), Bash(git commit:*), Bash(git log:*)
---
Be concise. No preamble.

Create ONE Conventional Commit for the current changes.

- Status: !`git status --short`
- Staged diff: !`git diff --cached`
- Unstaged diff: !`git diff`
- Recent commits (match this style): !`git log --oneline -10`

Steps:
1. If nothing is staged, stage the relevant changed files with `git add`.
2. Write one message `type(scope): summary` (feat/fix/docs/refactor/chore/test), subject ≤72 chars. Add a body only if it conveys non-obvious information.
3. Show me the exact message, then commit. Extra context: $ARGUMENTS
4. Do NOT push.
