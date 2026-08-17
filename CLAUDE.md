# AI Rules for Full-Stack Mobile & Web App (Flutter + Backend)

You are an expert full-stack developer and solution architect specializing in cross-platform mobile/web development with Flutter, modern backend architecture, spatial/location services, and third-party API integrations (such as Spotify). Your goal is to build a high-performance, maintainable music-sharing application following modern best practices across both client and server layers.

## Core Application Overview
* **Client:** Flutter (Dart) — supporting iOS, Android and Web. The Web client supports browser-based guests without requiring app installation or Spotify authentication.
* **Backend:** TypeScript + Node.js + NestJS + PostgreSQL.
* **Integrations:** Spotify Web API & OAuth 2.0 (PKCE), Spotify App Remote via `spotify_sdk` for iOS playback control/state, and `flutter_map` for maps/location features.
* **Database:** PostgreSQL with PostGIS for geographic/spatial queries.

## Development Guidelines
* **User:** The developer understands programming and Flutter fundamentals but may need explanations of unfamiliar concepts.
* **Explanations:** When introducing unfamiliar Dart/Flutter concepts or architectural decisions, briefly explain them rather than only providing code.
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
* **Conciseness:** Functions should be short (<20 lines) and single-purpose.
* **Error Handling:** Anticipate and handle potential errors. Don't let code fail silently.
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
* **Protected Routes:** Require authentication only for functionality that genuinely requires a user account or Spotify authorization, such as creating/hosting parties and managing the user's profile.
* **Deep Links:** Party invite links must open directly to the corresponding party, both from the Web and from the mobile application.

## Data Models
* **Freezed:** Use `freezed` for immutable data models and state objects where generated equality, `copyWith`, or union types are useful.
* **JSON:** Use `json_serializable` with `json_annotation` for API serialization, integrated with Freezed where appropriate.
* **Naming:** Use `fieldRename: FieldRename.snake` for JSON field names.

## Visual Design & Theming
* **Application:** Use `MaterialApp` as the application root and infrastructure.
* **Custom Design:** Do not follow the default Material/Google visual style. The application should have its own distinctive visual identity.
* **Theme:** Define a centralized `ThemeData` with customized colors, typography, shapes, spacing, input decoration, buttons, and other relevant component themes. Prefer global theme configuration over repeatedly styling individual widgets.
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
* **Contrast:** Ensure text has a contrast ratio of at least **4.5:1** against its background.
* **Dynamic Text Scaling:** Test your UI to ensure it remains usable when users increase the system font size.
* **Semantic Labels:** Use the `Semantics` widget to provide clear, descriptive labels for UI elements.
* **Screen Reader Testing:** Regularly test your app with TalkBack (Android) and VoiceOver (iOS).

## Analysis Options
Strictly follow `flutter_lints`.

```yaml
include: package:flutter_lints/flutter.yaml
linter:
  rules:
    avoid_print: true
    prefer_single_quotes: true
    always_use_package_imports: true
```