---
name: feature-development
description: Implement a new or substantially changed feature following the project's architecture, testing, and development conventions. Use when implementing non-trivial application functionality.
---

# Feature Development

## Workflow

1. **Understand the Feature**
   - Read the relevant existing feature code before making changes.
   - Identify the required user behavior, data flow, dependencies, and affected layers.
   - Check existing tests and related implementations for established patterns.

2. **Plan the Changes**
   - Determine which feature and layers need to change.
   - Reuse existing abstractions and components when appropriate.
   - Avoid introducing new architecture, dependencies, or abstractions without a clear need.

3. **Implement by Layer**
   - Keep feature-specific code inside its feature directory.
   - Keep presentation, domain logic, and data access separated according to the project structure.
   - Keep external integrations behind appropriate repositories or services.
   - Follow existing Riverpod patterns for state management and dependency injection.

4. **Handle States and Errors**
   - Consider loading, success, empty, and error states where applicable.
   - Handle expected failures at the appropriate layer rather than hiding them in the UI.
   - Preserve existing error-handling conventions.

5. **Write Tests**
   - Add or update tests for non-trivial behavior introduced by the feature.
   - Prefer unit tests for isolated logic and widget tests for important UI behavior.
   - Add integration tests only when the feature contains a critical end-to-end flow.
   - Test behavior and requirements rather than implementation details.

6. **Verify the Implementation**
   - Run formatting and static analysis.
   - Run the relevant test suite.
   - Fix failures caused by the implementation rather than weakening or removing tests.
   - Review the final changes for unnecessary complexity, duplicated logic, and violations of project structure.

## Completion Criteria

A feature is not complete until:
- The implementation follows the project architecture.
- Relevant tests are added or updated.
- Formatting and static analysis pass.
- Relevant tests pass.
- No unrelated code or tests were changed unnecessarily.