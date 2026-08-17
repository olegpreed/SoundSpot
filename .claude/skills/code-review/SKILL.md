---
name: code-review
description: Review Flutter code changes for correctness, architecture, maintainability, testing, and unnecessary complexity. Use after implementing a feature, fixing a bug, or making a significant refactor.
---

# Code Review

## Review Workflow

1. **Understand the Changes**
   - Read the changed files and relevant surrounding code.
   - Understand the intended behavior before evaluating the implementation.
   - Check whether the changes follow existing project patterns.

2. **Check Correctness**
   - Look for logic errors, incorrect state handling, race conditions, and unhandled edge cases.
   - Verify loading, success, empty, and error states where applicable.
   - Check that external API and platform interactions handle expected failures correctly.

3. **Check Architecture**
   - Verify feature boundaries are respected.
   - Check that presentation, domain, and data responsibilities remain separated.
   - Look for unnecessary coupling between components.
   - Check that dependencies can be replaced for testing where appropriate.

4. **Check Tests**
   - Verify that non-trivial behavior has appropriate test coverage.
   - Check that tests validate observable behavior rather than implementation details.
   - Look for missing important success, failure, and edge cases.
   - Do not require tests for trivial code without meaningful behavior.

5. **Check Maintainability**
   - Identify unnecessary abstractions, duplication, or complexity.
   - Prefer simple solutions that fit the existing architecture.
   - Check naming, readability, and consistency with the project conventions.
   - Avoid unrelated refactoring.

6. **Verify**
   - Run relevant tests and static analysis when possible.
   - Treat failures as issues to investigate rather than automatically modifying tests or suppressing errors.

## Review Output

Report findings by severity:
- **Critical:** Bugs, broken functionality, data loss, security issues, or serious architectural violations.
- **Major:** Significant correctness, testing, or maintainability problems.
- **Minor:** Small issues that should be improved but do not block the change.

Do not report purely stylistic preferences when the existing code already follows project conventions.