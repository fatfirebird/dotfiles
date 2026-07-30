---
name: review
description: Run an isolated, read-only expert review of current Git changes. Invoke explicitly with /skill:review, optionally followed by a review focus.
disable-model-invocation: true
---

# Review Current Changes

Delegate the review to the `reviewer` subagent so the review is independent and cannot modify the workspace.

## Procedure

1. Treat any text supplied after `/skill:review` as the requested review focus.
2. Call `subagent` with:
   - `agent: "reviewer"`
   - a task instructing it to inspect `git status` and all relevant staged and unstaged diffs
   - `context: "fresh"`
3. The reviewer must not modify files, run formatters, or apply fixes.
4. Ask it to review correctness, security, error handling, regressions, tests, performance, and maintainability. If a focus was supplied, emphasize it without skipping severe findings elsewhere.
5. Ask for actionable findings ordered by severity: blocker, high, medium, then low.
6. Require every finding to include the file and line, the problem, why it matters, and a concrete fix.
7. Report the review result directly. Keep findings separate from a short summary. If there are no findings, say so explicitly.

## Constraints

- Do not edit the workspace while performing this skill.
- Do not use a writer or implementation agent.
- Omit acceptance requirements because this is a read-only advisory review.
