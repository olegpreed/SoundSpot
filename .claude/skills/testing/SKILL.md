---
name: testing
description: Plan, write, update, and verify tests for Flutter application code. Use when adding or changing functionality, fixing bugs, or reviewing test coverage.
---

# Testing

## Workflow

1. **Identify Testable Behavior**
   - Determine what behavior or requirement is being introduced or changed.
   - Prefer testing observable behavior over implementation details.
   - Check existing tests before creating new ones and follow established patterns.

2. **Choose the Test Type**
   - Use unit tests for isolated business logic, validation, data transformations, repositories, services, and Riverpod logic.
   - Use widget tests for important UI behavior, state changes, rendering conditions, and user interactions.
   - Use integration tests selectively for critical end-to-end flows involving multiple layers or platform/external integrations.

3. **Design for Isolation**
   - Replace external dependencies with mocks or fakes where appropriate.
   - Keep tests deterministic and independent from network services, databases, and external APIs.
   - Prefer dependency injection so real implementations can be replaced easily.

4. **Cover Important Cases**
   - Test the normal successful behavior.
   - Test relevant loading, empty, invalid, and error states.
   - Include edge cases that could realistically cause regressions.
   - Do not add tests solely to increase coverage numbers.

5. **Write Maintainable Tests**
   - Keep each test focused on a clear behavior.
   - Use descriptive test names that explain the expected outcome.
   - Avoid excessive mocking and avoid duplicating implementation details in the test.
   - Reuse test helpers and fixtures when they improve clarity without hiding important behavior.

6. **Verify Changes**
   - Run the smallest relevant test suite first.
   - Run the broader test suite when changes affect shared code or multiple features.
   - Run formatting and static analysis when appropriate.
   - Investigate test failures and determine whether the implementation or the test is incorrect.

## Agent Rules

- Add or update tests when changing non-trivial behavior.
- Do not modify or remove a test merely to make the test suite pass.
- When a test fails unexpectedly, determine the underlying cause before changing the test.
- Prefer a small number of meaningful tests over large numbers of low-value tests.