---
name: backend-api
description: Implement and modify communication between the Flutter frontend and the project's NestJS backend API. Use when adding or changing API endpoints, repositories, services, models, authentication, or backend-driven feature behavior.
---

# Backend API

## Workflow

1. **Understand the Contract**
   - Read the existing OpenAPI documentation and related backend/frontend code before making changes.
   - Identify the endpoint, HTTP method, request body, response structure, authentication requirements, status codes, and expected errors.
   - Reuse existing API conventions rather than introducing new patterns unnecessarily.

2. **Respect the Architecture**
   - Keep HTTP communication inside the data layer.
   - Keep API-specific communication and serialization inside dedicated services.
   - Use repositories to expose application-level operations to the rest of the feature.
   - Do not make HTTP requests directly from screens, widgets, or presentation controllers/providers.
   - Keep API models separate from domain models when their structures or responsibilities differ.
   - For live/shared state (party playlist, votes, playback state), use the WebSocket channel described in CLAUDE.md's Realtime Communication section, not polling. Keep socket connection management inside the data layer behind the same repository used for the resource's REST operations, and expose it to presentation as a stream/state.

3. **Implement Changes**
   - Update the API contract and OpenAPI documentation when adding or changing endpoints.
   - Keep request and response formats explicit and consistent with the existing API contract.
   - Implement frontend and backend changes against the same contract.
   - Avoid introducing feature-specific API logic into shared infrastructure unless it is genuinely reusable.

4. **Handle Errors**
   - Handle network failures, authentication failures, authorization errors, validation errors, not-found responses, conflicts, and server errors where applicable.
   - Convert API-specific errors into application-level errors before they reach presentation code.
   - Preserve useful error information for appropriate UI feedback without exposing unnecessary backend details.

5. **Authentication**
   - Keep authentication and token handling out of presentation code.
   - Reuse the project's established authentication and credential management mechanisms.
   - Never hard-code tokens, passwords, client secrets, or other sensitive credentials.
   - Store tokens on-device using secure storage (e.g. `flutter_secure_storage`), never plain shared preferences/local storage.

6. **Security & Logging** (real backend only — see CLAUDE.md's Backend Security and Backend Audit Logging)
   - Every authenticated endpoint must derive the acting user from the verified token, never a client-supplied ID, and must enforce ownership/visibility checks before returning or mutating a resource.
   - Enforce guest-facing rules (e.g. one vote per identity per track) server-side; never trust the client to have already enforced them.
   - Rate-limit authentication-sensitive endpoints to mitigate brute-force attempts.
   - Ensure every request is captured by the global logging interceptor/middleware rather than adding ad-hoc logging per handler.
   - Not applicable to fake/mock repositories during the mock-backend phase.

7. **Fake Backend**
   - Fake repositories and services must follow the same API contract and application behavior as the real backend.
   - Use in-memory state when the feature requires mutable data during frontend development.
   - Simulate relevant loading, success, empty, and failure states where useful.
   - Keep fake implementations replaceable through dependency injection without changing presentation or domain code.

8. **Testing**
   - Do not depend on the live backend for unit or widget tests.
   - Use mocks or fakes for API services and repositories.
   - Test request construction, response parsing, repository behavior, and relevant failure cases.
   - Update tests when the API contract changes.

9. **Verification**
   - Verify that frontend models, repositories, services, and backend endpoints remain consistent.
   - Verify that OpenAPI documentation matches the implemented API.
   - Run formatting, static analysis, and relevant tests after changes.
   - When changing an API contract, verify both the backend behavior and the frontend integration.