# AI Rules for Full-Stack Mobile & Web App (Flutter + Backend)

You are an expert full-stack developer and solution architect specializing in cross-platform mobile/web development with Flutter, modern backend architecture, spatial/location services, and third-party API integrations (such as Spotify). Your goal is to build a high-performance, maintainable music-sharing application following modern best practices across both client and server layers.

## Core Application Overview
* **Client:** Flutter (Dart) — supporting iOS, Android and Web. The Web client supports browser-based guests without requiring app installation or Spotify authentication.
* **Backend:** TypeScript + Node.js + NestJS + PostgreSQL (planned; initially mocked during frontend development).
* **Integrations:** Spotify Web API & OAuth 2.0 (PKCE), Spotify App Remote via `spotify_sdk` for iOS playback control/state, and `flutter_map` for maps/location features.
* **Database:** PostgreSQL with PostGIS for geographic/spatial queries.

## Core Domain Model
* **Party:** A location-pinned gathering built around a single shared playlist. A party is either public (discoverable on the map) or private (joinable only via an invite link/QR code). A party has exactly one host and any number of guests.
* **Playlist Seeding:** When creating a party, the host either imports an existing playlist from their own Spotify library, imports a playlist found via Spotify's global playlist search, or starts from an empty playlist. Seeding is a one-time copy of track data into our backend at creation time — there is no ongoing sync with the source Spotify playlist afterward.
* **Host:** The Spotify-authenticated user who creates and owns a party. Only the host's device plays audio, via Spotify Connect/App Remote. The host can end the party explicitly at any time. A party otherwise stays open indefinitely — there is no automatic expiration and no automatic closing on host disconnect.
* **Guest:** A participant who joins a party to view the shared playlist, add tracks, and vote. Guests never authenticate with Spotify and never receive playback audio themselves — they only observe the host's synced playback state (current track, progress).
* **Track-Adding Permission:** Each party has a host-controlled switch for whether non-host participants may add tracks. The host can always add tracks regardless of this switch. Voting is always allowed for everyone and is unaffected by this switch.
* **Single Active Party:** A user (host or participant) may be actively in at most one party at a time on the mobile app. Joining a different party requires leaving or ending the current one first.
* **Track:** An entry in a party's shared playlist, added individually via Spotify catalog search (by host or guest) or included via playlist seeding at creation. Once added, a track is copied into our own backend as party-owned data — the party playlist is never written back to Spotify as a real Spotify Playlist object, and the host's actual Spotify library/playlists are never modified by the app. Ordered by net vote score (upvotes minus downvotes). (Optional, deferred: letting a host export a finished party's tracks to a real Spotify playlist is a possible later enhancement — do not build it until explicitly requested.)
* **Vote:** An upvote or downvote cast by a host or guest identity on a track. Each identity may cast at most one vote per track at a time; a vote can be changed or retracted. Vote counts are visible to all participants.
* **Invite Link / QR Code:** A QR code is simply a scannable encoding of the same deep-link URL used for link-based invites. There is no separate QR-specific join token or backend logic.

## Guest Identity
* **Identity Mechanism:** Guests are identified by a device-generated UUID persisted in local/browser storage on first visit, paired with a guest-chosen display name shown next to tracks they add and votes they cast.
* **Not Authentication:** This identity mechanism is independent of Spotify authentication and is not "authentication" for the purposes of the Initial Development Phase restrictions below. It is required for core party participation (voting, adding tracks) and should be implemented even during the mock-backend phase.
* **Platform Scope:** Unauthenticated guest participation is Web-only. The mobile app (iOS/Android) always requires Spotify authentication to participate in a party in any capacity, including as a non-host participant.

## Host Profiles & Social
* **Public Profile:** Every Spotify-authenticated user has a public profile with a unique display name, an avatar, and their top artists pulled from Spotify.
* **Discovery:** Users can search for other hosts by display name and view their public profile.
* **Following:** Users can follow other hosts from their profile page.
* **Notifications (Deferred):** In-app notifications when a followed host starts a party are an optional, later-stage feature. Do not build notification infrastructure for this until explicitly requested — the profile, search, and follow relationship should still be implemented in stage 1.

## Location & Discovery
* **Party Location:** A party's map location is a pin chosen by the host at creation time, using exact real-world coordinates (not fuzzed), since guests need to physically find the gathering. The host can adjust the pin after creation; the pin does not otherwise follow the host's live position.
* **Discovery:** Public parties are discoverable on the map using their pinned location. Private parties are never shown on the public map and are reachable only via invite link/QR code.
* **Proximity-Gated Joining:** Joining a public party requires the joiner (mobile app user or web guest) to be within that party's join radius of its pin, checked via the joiner's current device/browser location. The join radius is set by the host at party creation (bounded 50m–500m, default 150m) rather than a fixed app-wide constant. Joining a private party via invite link/QR is exempt from this check — possessing the invite is the gate.
* **Location Access:** Use a dedicated geolocation package (e.g. `geolocator`) for obtaining device location, isolated behind a repository/service consistent with the rest of the app's data-layer conventions.

## Backend Communication
* **API Boundary:** Communicate with the backend through the data layer rather than directly from presentation code.
* **Repositories:** Repositories expose application-level operations to the rest of the feature and hide HTTP/API details.
* **Services:** Keep HTTP communication and API-specific logic inside dedicated services.
* **Models:** Keep backend API models separate from domain models when their structures or responsibilities differ.
* **Error Handling:** Convert API and network errors into application-level errors before they reach presentation code.

## Backend Architecture
* **Repository Abstraction:** Features should depend on repository contracts rather than concrete API implementations.
* **Real & Fake Implementations:** Provide separate real and fake repository implementations when useful for development and testing.
* **Dependency Injection:** Select repository implementations through dependency injection rather than constructing concrete implementations inside presentation or domain code.
* **Replaceability:** The frontend should be able to switch between fake and real backend implementations without changing presentation code.
* **API Isolation:** Keep HTTP and backend-specific details inside the data layer and prevent them from leaking into presentation or domain logic.

## API Contract
* **Protocol:** Use REST over HTTPS with JSON request and response bodies.
* **Versioning:** Prefix API routes with `/api/v1/`.
* **Resources:** Use plural resource names and standard HTTP methods.
* **IDs:** Use UUIDs for backend resource identifiers.
* **Responses:** Return the resource or result directly in the response body rather than wrapping successful responses in unnecessary envelopes.
* **Errors:** Use a consistent JSON error structure containing an error code, human-readable message, and optional validation details.
* **Status Codes:** Use standard HTTP status codes consistently (e.g. `200`, `201`, `204`, `400`, `401`, `403`, `404`, `409`, `422`, `500`).
* **Pagination:** Use explicit pagination parameters such as `page` and `limit` for collection endpoints that may grow large.
* **Filtering:** Use query parameters for filtering, sorting, and search rather than creating separate endpoints for each variation.
* **Authentication:** Use `Authorization: Bearer <token>` for authenticated backend requests. Guest-accessible endpoints must explicitly define their authentication requirements.
* **Contract Source of Truth:** Keep the API contract documented with OpenAPI/Swagger and update it whenever an endpoint changes.
* **Fake Backend:** Fake repositories and services must follow the same request/response behavior and error semantics as the real API.
* **API Documentation:** Document the backend API using OpenAPI/Swagger and keep the documentation synchronized with the implemented API contract.

## Backend Security
* **Data Isolation:** Every authenticated endpoint must derive the acting user from the verified access token — never from a client-supplied ID — and must enforce ownership/visibility checks before returning or mutating a resource. A user must never be able to read or modify another user's private data through the API.
* **Session & Token Security:** Use short-lived access tokens with refresh-token rotation. Rate-limit authentication-sensitive endpoints (e.g. via NestJS's built-in throttler) to mitigate brute-force attempts. Store tokens on-device using secure storage (e.g. `flutter_secure_storage`) rather than plain shared preferences/local storage.
* **Guest Requests:** A guest identity (device UUID) is not a security credential. Treat guest-scoped endpoints as untrusted input and enforce rules server-side, not just client-side — e.g. the one-vote-per-identity-per-track rule from Core Domain Model must be enforced by the backend regardless of what the client sends.
* **Threat Model:** A written threat model (identified hazards + practicable mitigations) is a required project deliverable, deferred until the real backend exists with concrete endpoints and an actual attack surface to reason about.

## Backend Audit Logging
* **Requirement:** Every API request from any client (mobile, web) must generate a backend log entry, including read requests, not just mutations.
* **Log Content:** Each entry must include, at minimum: the acting identity (authenticated user ID or guest UUID), timestamp, endpoint/method, and outcome (status code / success-failure).
* **Implementation:** Implement this as a single logging interceptor/middleware applied globally in NestJS, rather than adding manual logging calls inside individual handlers.
* **Fake Backend:** Not applicable to fake/mock repositories — this is a real-backend requirement and does not need to be simulated during the mock-backend phase.

## Realtime Communication
* **Mechanism:** Use WebSocket connections (NestJS Gateway) to push live updates to all connected party participants — track additions, vote changes, resulting order, and host playback state.
* **REST vs Realtime:** Use REST for standard CRUD operations (creating a party, fetching initial playlist state, profile/follow actions) and the WebSocket channel for live push updates after the initial load.
* **Isolation:** Keep WebSocket connection management inside the data layer, behind the same repository abstractions used for REST. Presentation code should consume a stream/state, not manage the socket directly.
* **Fake Backend:** Fake repositories must simulate realtime updates using a local `Stream`/broadcast mechanism so presentation code depends on the same reactive interface regardless of which backend implementation is active.

## Load & Capacity
* **Target Deployment:** The real backend targets a small, low-end cloud VPS (comparable to a $5–10/month tier), consistent with a friends-scale, non-App-Store deployment. Do not design or provision for large-scale traffic.
* **Capacity Goal:** Design and validate the backend to reliably support on the order of dozens to low hundreds of concurrent users on that hardware class, not thousands.
* **Benchmarking:** Once the real backend exists, measure actual capacity with a load-testing tool (e.g. Apache Bench, Gatling, or k6) against the target VPS specs, and document the measured results alongside the declared server characteristics (CPU/RAM/provider).
* **Scope:** This is a one-time measurement/documentation deliverable once the backend is built, not an ongoing constraint on frontend or mock-phase work.

## Development Guidelines
* **User:** The developer understands programming and Flutter fundamentals. They have already studied Riverpod and want to internalize it through real usage in this codebase — treat Riverpod as reinforcement, not first-time teaching. The backend (TypeScript/NestJS/PostgreSQL) is new to them and needs fuller, first-time-level explanation when that work begins.
* **Explanations:** When introducing unfamiliar Dart/Flutter concepts or architectural decisions, briefly explain them rather than only providing code. For Riverpod specifically, connect new usage to concepts they already know rather than re-explaining fundamentals from scratch. For backend work, explain more thoroughly since it's new territory for them.
* **Clarification:** If ambiguity could materially affect architecture, behavior, or platform compatibility, ask before implementing. Otherwise make a reasonable assumption and state it.
* **Dependencies:** Before adding a dependency, explain why it is needed and what alternatives were considered. Prefer existing dependencies when possible.
* **Formatting:** Run `dart format` on modified Dart files before completing a task.
* **Quality:** Run `flutter analyze` and relevant tests after making changes. Follow the rules in `analysis_options.yaml`.

## Flutter Style Guide
* **Composition over inheritance:** Prefer composition and small, reusable widgets over complex inheritance hierarchies.
* **Immutability:** Prefer immutable data and widgets. Use `const` constructors where appropriate.
* **State separation:** Keep ephemeral UI state separate from shared application state.
* **Separation of concerns:** Keep UI, business logic, data access, and external integrations appropriately separated.
* **Simplicity:** Prefer the simplest implementation that fits the project's architecture. Avoid unnecessary abstractions, layers, or design patterns.

## Flutter Code Quality
* **Naming:** Avoid abbreviations. Use `PascalCase` (classes), `camelCase` (members), `snake_case` (files).
* **Functions:** Keep functions focused and single-purpose. Avoid unnecessary complexity.
* **Logging:** Use `dart:developer` `log` instead of `print`.
* **Error Handling:** Handle expected failures explicitly and use meaningful exception/error types where appropriate. Don't silently swallow errors.

## State Management
* **Riverpod:** Use Riverpod with Riverpod Generator for application state management and dependency injection. Prefer generated providers over manually declared providers where supported.
* **Provider Selection:** Choose the appropriate Riverpod provider type based on the state and its lifecycle. Prefer simple providers when possible; don't introduce unnecessary complexity.
* **Separation:** Keep ephemeral UI state local to the widget when it doesn't need to be shared. Use Riverpod for shared or application-level state.
* **Architecture:** Keep UI, business logic, and data access separate. Riverpod providers should coordinate application state and dependencies rather than becoming large containers for unrelated logic.
* **Dependencies:** Prefer explicit dependencies and avoid global mutable state outside Riverpod.

## Routing
* **Router:** Use `go_router` for navigation and deep linking across iOS and Web.
* **Public Web Routes:** The Web client must support unauthenticated access to public functionality, including:
  - Public party/map discovery.
  - Joining a party through an invite/deep link.
  - Viewing and participating in a party's playlist.
  - Searching tracks and participating in voting where permitted.
* **Protected Routes:** Require authentication only for functionality that genuinely requires a user account or Spotify authorization, such as creating/hosting parties, following other hosts, and managing the user's profile.
* **Deep Links:** A private party's invite link opens directly to that party's Party Preview/Active view, both from the Web and from the mobile application. A public party's invite link instead opens the Map view centered on that party's pin — public parties are surfaced via the map rather than a direct preview, so the recipient sees the pin and taps into it, proceeding to Party Preview as normal from there.
* **Guest Scope:** Unauthenticated participation applies to the Web client only — see Guest Identity. The mobile app always requires Spotify authentication, even to join as a non-host participant.
* **Screen Inventory:** See [NAVIGATION.md](NAVIGATION.md) for the concrete screen list and navigation flow. Consult it before implementing or restructuring any screen so new work fits the planned flow rather than diverging from it.

## Data Models
* **Freezed:** Use `freezed` for immutable data models and state objects where generated equality, `copyWith`, or union types are useful.
* **JSON:** Use `json_serializable` with `json_annotation` for API serialization, integrated with Freezed where appropriate.
* **Naming:** Use `fieldRename: FieldRename.snake` for JSON field names.

## Visual Design & Theming
* **Application:** Use `MaterialApp` as the application root and infrastructure.
* **Custom Design:** Do not follow the default Material/Google visual style. The application should have its own distinctive visual identity.
* **Theme:** Define a centralized `ThemeData` with customized colors, typography, shapes, spacing, input decoration, buttons, and other relevant component themes. Prefer global theme configuration over repeatedly styling individual widgets.
* **Highlight/Seed Color:** The design's green highlight/accent color is a single configurable seed value defined once in the theme, not hardcoded per-widget. Derive tonal shades and opacity variants of it from that seed (e.g. via `ColorScheme.fromSeed` or an equivalent seed-based palette utility) rather than defining separate hardcoded greens across the app.
* **Typography:** Use a single font family across the entire app, defined once in the theme's `textTheme`/`fontFamily` and varied only by weight/size, rather than mixing multiple font families per screen or widget.
* **Reusable Components:** Create reusable custom components for recurring UI elements such as buttons, inputs, cards, dialogs, and navigation. Reuse existing components rather than creating separate implementations for each screen.
* **Dark Theme:** The application uses a dark theme only. Do not implement a light theme unless explicitly requested.
* **Platform Neutrality:** Do not use Cupertino-specific styling or platform-adaptive UI. The visual appearance should remain consistent across iOS and Web.
* **Consistency:** Follow the established theme and existing component styles when implementing new screens. Do not introduce new visual styles without a reason.
* **Responsive Design:** Interfaces must adapt appropriately to different screen sizes, particularly between mobile and Web.
* **Design References:** Screenshots in `design/` are visual references for the intended UI. Inspect relevant references before implementing corresponding screens.

## Layout
* **Responsive Design:** Build layouts that adapt to different screen sizes, particularly between mobile and Web.
* **Scrolling:** Use lazy builders such as `ListView.builder` and `GridView.builder` for potentially large collections.
* **Overflow:** Avoid layouts that can overflow on smaller screens. Prefer responsive layouts over hardcoded dimensions where appropriate.

## Documentation
* **Comments:** Write comments to explain why something is done, not what the code obviously does.
* **Doc Comments:** Use `///` for public APIs that require documentation.
* **Useful Documentation:** Document non-obvious behavior, architectural decisions, and important setup or usage information. Avoid documenting self-explanatory code.
* **Consistency:** Use consistent terminology throughout the project.

## Accessibility
* **Basic Accessibility:** Maintain reasonable text contrast and ensure interactive elements have clear labels and usable touch/click targets.

## Project Structure
* **Feature-first:** Organize application code primarily by feature under `lib/features/`.
* **Core:** Use `lib/core/` only for functionality genuinely shared across multiple features, such as routing, theming, configuration, and reusable UI components.
* **Feature Boundaries:** Keep feature-specific code inside its feature directory. Avoid creating global folders for feature-specific models, widgets, repositories, or services.
* **Presentation:** Organize feature UI into screens, widgets, and Riverpod providers/controllers as appropriate.
* **Data & Domain:** Keep data access and external integrations separate from presentation. Organize repositories, services, data sources, and models into appropriate subdirectories within the feature. Keep domain models independent of UI.
* **Generated Code:** Keep generated files alongside the source files that generate them.
* **Tests:** Mirror the `lib/` structure under `test/`, keeping tests organized by feature and by the layer they cover.

## Testing
* **Unit Tests:** Test business logic, data transformations, validation, and other isolated logic with unit tests.
* **Widget Tests:** Test important UI behavior and interactions with widget tests.
* **Integration Tests:** Use integration tests selectively for critical end-to-end user flows.
* **Test Behavior:** Test observable behavior and requirements rather than implementation details.
* **Mocking:** Mock external dependencies such as APIs and databases in unit/widget tests.
* **Agent Workflow:** When implementing or changing non-trivial functionality, add or update appropriate tests and run the relevant test suite.
* **Quality:** Do not modify tests merely to make them pass without verifying that the underlying behavior is correct.

## Mocking Strategy
* **Interfaces:** Use abstract repositories or service contracts when a dependency has multiple implementations or needs to be easily replaced in tests/development.
* **Mock Implementations:** Provide mock/fake implementations for external services and repositories when testing or developing UI without the real backend.
* **Realistic Behavior:** Mocks should support realistic loading, success, empty, and error states. Simulate network delays only when needed to test loading behavior.
* **Configurable Failures:** Where useful, mocks should allow specific failure cases to be triggered, such as API errors, permission denial, or unavailable data.
* **In-Memory State:** Use in-memory state for mocks when UI features require mutable data during development or testing, such as creating, updating, or voting on playlist items.

## Spotify Integration
* **Architecture:** Keep Spotify-specific logic isolated from UI code behind services/repositories.
* **Authentication:** Spotify authentication is handled separately from the application's own guest/party participation system.
* **Host:** The authenticated Spotify user is the party host. Guests do not need Spotify authentication to participate in public or invited parties.
* **Playback:** Only the host's device outputs audio, via Spotify App Remote / Spotify Connect. Guests never receive or play audio directly — they only observe the host's synced playback state (current track, progress) over the realtime channel. Playback control must not be required for guest functionality.
* **App Remote Scope:** Spotify App Remote (`spotify_sdk`) establishes a direct, on-device connection between the host's app and the Spotify app installed on the host's phone — it is not proxied through the backend. The backend only relays the resulting playback state to guests over the realtime channel; it never sends playback commands to Spotify on the host's behalf.
* **Token Strategy:** Use each authenticated user's own OAuth token for host-only Web API calls — their profile, top artists, importing from their own library, and playlist search during party creation (all host-only actions). Use a separate app-level Client Credentials token (independent of any user) only for track search, since that's the one catalog operation guests also perform, and guests never hold a Spotify token. A guest identity is never used as, or in place of, a Spotify credential.
* **Profile Data:** Use the Spotify Web API to populate a host's public profile (avatar, top artists) as described in Host Profiles & Social.
* **Mocking:** During the initial frontend phase, use mock Spotify data/services rather than making real Spotify API calls. Keep the interfaces compatible with the eventual Spotify integration.

## Web Deep Link Mocking
* **Public Web Views:** Only views intended to be accessible without app authentication, such as the public map and guest playlist participation, should support web deep links.
* **Deep Link Testing:** Support mock route and query parameters in `go_router` to allow development and testing of these public flows directly from the browser URL.
* **Role Simulation:** Use URL parameters to simulate roles such as Host and Guest without requiring separate authentication flows during development.
* **App-Only Views:** Do not expose app-only authenticated views through public web deep links unless explicitly required by the feature.
* **Production Safety:** Mock role/query parameters must be inert outside debug/development builds (e.g. gated by `kDebugMode` or an explicit dev-only configuration flag) so they can never be used to fake host/guest privileges once the app is connected to the real backend.

## Initial Development Phase
* **Mock Backend:** The initial frontend phase uses mock data/services instead of a live NestJS backend.
* **API Boundaries:** Design frontend data access through repositories/services so mock implementations can later be replaced by the real backend without rewriting UI code.
* **No Premature Infrastructure:** Do not implement authentication, database persistence, real Spotify API calls, or backend infrastructure unless explicitly requested.
* **Guest Identity Exception:** The lightweight guest identity mechanism (device ID + display name, see Guest Identity) is required for core party functionality and is not blocked by this rule — it is not user authentication.