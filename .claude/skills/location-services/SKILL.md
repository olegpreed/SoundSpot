---
name: location-services
description: Implement and modify location, map, and geolocation functionality for the Flutter application. Use when working with device location permissions, party map pins, map discovery, or `flutter_map`/`geolocator` integration.
---

# Location Services

## Workflow

1. **Understand the Requirement**
   - Read [CLAUDE.md](../../CLAUDE.md)'s Location & Discovery and Core Domain Model sections before implementing.
   - Determine whether the feature needs the device's current location (e.g. centering the discovery map, letting a host place a pin) or a party's stored pinned location (e.g. rendering a marker, computing distance).
   - Do not confuse the two: a party's location is a fixed pin chosen by the host, not the viewer's live position.

2. **Follow Project Architecture**
   - Keep `geolocator` (or equivalent) calls inside a dedicated service, exposed to features through a repository — do not call platform location APIs directly from screens or widgets.
   - Keep map rendering (`flutter_map`) in presentation widgets, but keep location data fetching and party-location persistence in the data layer.
   - Convert platform location errors (permission denied, service disabled, timeout) into application-level errors before they reach presentation code.

3. **Permissions**
   - Request only foreground location access; this app has no requirement for background location tracking.
   - Handle all permission states explicitly: not requested, denied, denied forever, and granted. Provide a clear path for the user to grant permission or proceed without it where the feature allows (e.g. manual map panning instead of centering on the user).
   - Never assume permission is granted; always check current status before using location.

4. **Party Pin Behavior**
   - A party's pin is set once at creation (typically defaulted to the host's current location) and can be adjusted afterward by dragging/re-placing it on the map — it does not track the host's live position afterward.
   - Store and transmit pins as exact coordinates (latitude/longitude); do not fuzz or round coordinates for privacy, since guests need the exact location to find the gathering.
   - Only public parties' pins are used for map discovery; private parties must not appear in any public/discovery map query.

5. **Mocking**
   - During the mock-backend phase, use a fake location repository that returns configurable coordinates (including permission-denied and service-disabled scenarios) rather than requiring a real device/emulator location.
   - Fake party repositories should support in-memory pin storage and updates consistent with the Mocking Strategy in CLAUDE.md.

6. **Testing**
   - Unit test distance/formatting/validation logic without a real location provider.
   - Test permission-denied, service-disabled, and successful-fetch states for any widget that requests live device location.
   - Do not depend on real GPS or a real map tile server in tests.

7. **Verification**
   - Run formatting, static analysis, and relevant tests after changes.
   - Verify map/location behavior manually (per the project's `run` workflow) since permission and map-rendering issues are easy to miss in unit tests alone.
