---
description: Explore codebase to find definitions, usages, and patterns
agent: explore
subtask: true
---

Explore the codebase to answer: $ARGUMENTS

Use the appropriate search strategy:
- For finding specific text/strings: use grep
- For structural code patterns (functions, classes): use ast_grep_search
- For file discovery: use glob

Search thoroughly and return all relevant matches with file paths and line numbers.
