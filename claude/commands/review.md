---
description: Fresh-eyes review of the working diff via a separate subagent
argument-hint: [optional focus area]
allowed-tools: Bash(git diff:*), Bash(git status:*), Task
---
Be concise. No preamble, no summary.

Delegate to a FRESH subagent to review the current diff:

!`git diff`

Instruct the subagent to report ONLY real problems -- correctness bugs, security issues, and clear simplifications -- ranked most-severe first. Format each as: `file:line -- problem -- suggested fix`. Optional focus: $ARGUMENTS

Return only the ranked findings.
