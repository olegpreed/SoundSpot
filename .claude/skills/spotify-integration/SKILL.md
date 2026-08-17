---
name: spotify-integration
description: Implement and modify Spotify Web API and Spotify App Remote integrations for the Flutter application. Use when working with Spotify authentication, playlists, tracks, search, user data, playback control, or player state.
---

# Spotify Integration

## Workflow

1. **Verify Spotify Requirements**
   - Read the current official Spotify documentation before implementing or changing Spotify functionality.
   - Verify the required endpoint, OAuth scope, authentication flow, request parameters, response structure, and platform requirements.
   - Never guess Spotify endpoints, fields, scopes, or SDK behavior.

2. **Follow Project Architecture**
   - Keep Spotify communication inside the data layer.
   - Keep Spotify-specific API models and serialization separate from domain models when appropriate.
   - Use repositories to expose application-level Spotify operations to the rest of the feature.
   - Do not call Spotify APIs directly from screens, widgets, or presentation controllers/providers.

3. **Authentication**
   - Use OAuth 2.0 Authorization Code with PKCE for user authorization where a client secret cannot be safely stored.
   - Request only the scopes required by the functionality being implemented.
   - Keep Spotify authentication and token handling outside presentation code.
   - Never hard-code client secrets, access tokens, refresh tokens, or other sensitive credentials.
   - Treat authentication requirements and available scopes as changeable; verify them against current Spotify documentation.

4. **Web API**
   - Use the Spotify Web API for Spotify catalogue, user, playlist, and other supported Web API functionality.
   - Follow Spotify's documented HTTP methods, request formats, response schemas, and error behavior.
   - Map Spotify API models into application/domain models where appropriate.
   - Do not expose Spotify-specific API details throughout the application unnecessarily.
   - Use the Web API to source profile data (avatar, top artists) for a host's public profile, per CLAUDE.md's Host Profiles & Social section. "Following" another host is this app's own social feature, backed by our own backend — it is unrelated to and must not be implemented using Spotify's own follow-artist/user API.
   - Use each user's own OAuth token for host-only calls (profile, top artists, library import, playlist search at party creation). Use a separate app-level Client Credentials token only for track search, since guests also perform track search and never hold a Spotify token themselves.
   - Never write the party's track list back to Spotify as a real Playlist object, and never modify a host's actual Spotify library/playlists. Party playlists are copied into and live entirely in our own backend — see CLAUDE.md's Core Domain Model (Playlist Seeding / Track).

5. **App Remote**
   - Use Spotify App Remote through the project's `spotify_sdk` integration only for functionality that requires controlling or observing the Spotify app on supported mobile platforms.
   - App Remote runs entirely on-device between the host's app and the Spotify app installed on the host's phone — do not route playback commands through the backend. Only the resulting playback state should reach the backend/other clients, over the realtime channel.
   - Keep App Remote platform-specific behavior isolated from the rest of the application.
   - Do not assume Web API playback endpoints and App Remote provide identical capabilities.
   - Verify required App Remote authorization and platform support in the current Spotify documentation.

6. **Platform Boundaries**
   - Remember that the Flutter Web client and mobile clients do not have identical Spotify capabilities.
   - Do not expose mobile-only Spotify functionality through Web without an explicit implementation and documented support.
   - Public guest web flows must not require Spotify authentication unless the feature explicitly requires it.

7. **Error Handling**
   - Handle authentication failures, insufficient scopes, unavailable resources, network failures, rate limiting, and Spotify API errors where applicable.
   - Convert Spotify-specific failures into application-level errors before they reach presentation code.
   - Provide appropriate user-facing behavior without exposing unnecessary Spotify API details.

8. **Testing**
   - Do not depend on the live Spotify API for unit or widget tests.
   - Use mocks or fakes for Spotify services and repositories.
   - Test important success, empty, loading, authentication, permission, and error states.
   - Keep platform-specific App Remote behavior isolated so the majority of application logic can be tested without a real Spotify connection.

9. **Verification**
   - Verify all Spotify-specific implementation decisions against the current official Spotify documentation.
   - Run formatting, static analysis, and relevant tests after changes.
   - When modifying Spotify authentication or permissions, verify that requested scopes and redirect URIs remain valid for the target platforms.