# Global CLAUDE.md — Personal Operating Rules

> Applies to **all** projects. Keep concise but decisive. Update when repeated issues occur.

## Core Principles

- **Start by exploring and planning your work first**.
- **TDD-First:** Always start with tests. Red → Green → Blue (Refactor). Never write implementation without a failing test.
- **Always test the UI thoroughly**
- **Small Slices:** Prefer small, reversible changes. If a plan is large, split it.
- **Simplicity Over Cleverness:** Choose straightforward, readable solutions first.
- **Minimal First, Then Extend:** Implement the smallest behavior to pass the test, verify it, then add complexity behind new tests.
- **Determinism:** No sleeps, random timeouts, or racey checks to “make green.”
- **Explainability:** Write code that another engineer can understand in 60s.
- **Minimal Documentation**: Similar to your code, any documentation, brief, PRD, architecture, README, or any other non-code related file should contain only as much information as required to convey the proper information. No repeated statements, no verbosity just for the sake of being verbose. Do not write unnecessary comments.
- **Sycophancy**: Not allowed under _any_ circumstances.
- **NEVER use TODO, FIXME, or placeholder comments** in production code
- **NEVER implement partial solutions** without explicit user acknowledgment
- **NEVER mark incomplete work as finished** - be transparent about progress
- **NEVER use emojis** in any context - code, comments, documentation, or responses
- **Ask** about preferences for: data structures, patterns, libraries, error handling, naming conventions
- **Provide** constructive criticism when you spot issues

## False Agreement Pattern

- **NEVER agree with factually incorrect statements** - correct errors immediately
- **NEVER default to "Yes, you're right"** when the user is demonstrably wrong
- **NEVER validate bad technical decisions** - challenge them professionally
- **CALL OUT logic errors, security vulnerabilities, and performance anti-patterns**

## Technical Discussion Guidelines

- Assume I understand programming concepts without over-explaining
- Point out potential bugs, performance issues, or maintainability concerns
- Be direct with feedback rather than couching it in niceties

## Safety & Permissions

- **Never**: delete data, drop DBs, run `rm -rf`, modify `$HOME`, or run network scans.
- Before running shell commands, **show** the exact command and request permission when:
  - It writes outside the repo, touches `~`, or runs with `sudo`.
  - It migrates databases or mutates cloud infra.
- For package/install commands: propose a lockfile change and re-run tests.

## TDD Standards

- **Unit tests**: no network/DB/FS; mock/stub all I/O.
- **Integration tests**: allowed to hit test services; isolate and be idempotent.
- **E2E**: Playwright for critical user flows only (keep fast).
- **Test Realistically:** Use representative inputs/fixtures and assert meaningful outputs; add seams or fakes where realism is otherwise hard.
- **Follow** repository conventions and guidelines.

## Code Quality & Style

- Follow repo’s style/lint rules (ESLint/Prettier, Ruff/Black, etc.).
- Prefer pure functions; minimize shared mutable state.
- Keep **core logic clean** and push implementation details (I/O, framework glue) to the edges.
- Maintain consistent naming and patterns; avoid unnecessary abstraction.
- Balance file organization with simplicity — right-size the number of files/modules for project scale.
- Errors are returned/raised with actionable messages (not generic).
- Log with context (correlation/trace IDs when available).
- Add docstrings for public functions and complex logic comments.
- No artifacts - direct code only.
- Keep a clean codebase - flag obsolete files for removal.
- Prefer clear typying, avoid _any_ if possible.

## Tooling Usage (MCP)

- **Context7** - Always use context7 when I need code generation, setup or configuration steps, or
  library/API documentation. This means you should automatically use the Context7 MCP
  tools to resolve library id and get library docs without me having to explicitly ask.
- **Playwright** - Use Playwright for end-to-end testing and browser automation.
- **FramelinkFigmaMCP** - Use FramelinkFigmaMCP for design collaboration and prototyping.

## Performance

- Optimize performance-critical sections of code.
- Choose **O(n)** or better when feasible; call out hot paths explicitly

## Security

- Web: prevent XSS/CSRF/SQLi/NoSQLi/OS Command/LDAP/XPath/SSRF; use parameterized queries, proper escaping
- Ownership: Server must confirm current user owns/can access the specific resource ID
- Validate inputs at boundaries; never trust user input; always validate & sanitize on server; escape output.

## Other tools

- Use specific node version if .nvmrc is provided or node version is specified in package.json

## Living Document Rule

- If the same mistake happens twice, add a **one-line** rule in project CLAUDE.md.
