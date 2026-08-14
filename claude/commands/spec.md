---
description: Interview me, then write SPEC.md before any implementation
argument-hint: [feature name]
allowed-tools: AskUserQuestion, Read, Grep, Glob, Write
---
Be concise. Ask tight questions, no filler.

Goal: produce a precise spec for **$ARGUMENTS**. Do NOT write implementation code.

1. Use AskUserQuestion to interview me on requirements, scope, edge cases, constraints, and acceptance criteria. Batch questions; continue until the feature is unambiguous.
2. Write the result to `SPEC.md`: problem, requirements, out-of-scope, key decisions, acceptance criteria, open questions.
3. Tell me to implement in a fresh session against `SPEC.md`.
