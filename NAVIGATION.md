# SoundSpot Navigation

Screen inventory and navigation flow, referenced from [CLAUDE.md](CLAUDE.md). See `design/` for visual references per screen — this document covers structure and flow only, not visual style.

## Platforms

- **Mobile app (iOS/Android):** full experience. Every participant — host or not — is Spotify-authenticated (see CLAUDE.md's Guest Identity: unauthenticated participation is Web-only).
- **Web:** guest-only, unauthenticated. Two reachable views — Map and Party (P) — cross-navigable, entered either directly via a shared link or by browsing from Map.

---

## Bottom Chrome (Mobile)

The bottom bar is not a fixed widget — its content depends on which screen is showing:

- **Main (Map / Party / Profile tabs):** standard 3-icon tab bar (pin / Party / person). The center (Party) icon is contextual: a plain "+" when the user has no active party ("create"); once the user has an active party ("playlist mode"), it switches to a play/pause control reflecting live playback state (host can tap it to toggle playback without leaving the tab bar).
- **Party (Active):** the tab bar is replaced by: back navigation (left, app back-navigation — not a playback control, available to host and guest alike), play/pause (center, host-controlled, reflects live playback state), add-track (right, respects the track-adding toggle; always enabled for host).
- **Party Preview:** the tab bar is replaced by just two actions — Back and Join. The back action is omitted entirely (not shown disabled) when there's nowhere to go back to — e.g. a private party's invite link opens directly here with no prior screen in the navigation stack (see Deep Links in CLAUDE.md).

Non-host participants see the same Party (Active) bottom bar but without playback control authority (play/pause is disabled) — see Party (Active) below. Back navigation and add-track are unaffected by host/guest role.

## Mobile App Screens

### 1. Sign In
Spotify OAuth (PKCE). Creates a backend user on first login if one doesn't already exist. Entry point before the Main view; no unauthenticated screens exist on mobile.

### 2. Main (bottom navbar: Map / Party / Profile)

**Map tab** (default view)
- Public party pins only (private parties never appear here — Location & Discovery).
- Tap a pin → Party Preview (see below).

**Party tab (P)**
- If the user isn't active in any party: empty state with a "Create Party" CTA → Party Creation flow.
- If the user is active in a party (as host or joined participant): shows that party's live view → Party (Active).
- A user is active in at most one party at a time.

**Profile tab**
- Spotify avatar, username, top artists.
- Current party, if active (links to Party tab).
- Followers count / Following count → Follower/Following List.
- Search entry point → Host Search.
- Edit action (own profile only).

### 3. Party Creation (wizard, 3 steps)
1. Name input.
2. Public/private switch.
   - Public → choose pin location on map; set the party's join radius (host-configurable, 50m–500m, default 150m — see Location & Discovery).
   - Track-adding switch (non-host participants allowed to add tracks or not; the host can always add regardless; voting is always allowed regardless).
3. Playlist seeding: import from the host's Spotify library, search Spotify's global playlist catalog, or start from scratch.

Completing the wizard creates the party and lands on Party (Active) as host.

### 4. Party Preview
Bottom chrome: Back + Join only (see Bottom Chrome above). Read-only view of a party's current track list, reached by tapping a map pin or opening a private party's invite link (mobile deep link). A public party's invite link opens the Map tab centered on that party's pin instead of Party Preview directly — see Deep Links in CLAUDE.md; from there, tapping the pin reaches Party Preview as usual. Once reached, Preview/Join behaves the same for public and private parties — private parties skip only the proximity check, not the Preview/Join step itself.
- **Join** action:
  - Public party: proximity-checked against the party's pin, using that party's configured join radius; blocked with a distance message if too far.
  - Private party: no proximity check — possessing the invite link/QR is the gate.
  - If the user is already active in a different party, the join is blocked with a prompt to leave/end the current party first, rather than switching silently.
- On join, transitions to Party (Active) as a non-host participant.

### 5. Party (Active)
Bottom chrome: transport bar, replacing the main tab bar (see Bottom Chrome above). Shared for host and non-host participants, with role-specific controls:
- Track list ordered by net vote score; vote (upvote/downvote, changeable/retractable) available to everyone.
- Add-track button → Track Search (hidden for non-host participants if the party's track-adding toggle is off; always visible to the host).
- Participant count.
- Host-only: playback controls (play/pause/next — commands `spotify_sdk` App Remote directly on the host's device), Invite button (opens a share sheet offering three options: native OS share, copy link to clipboard, or show QR code — the QR is just a rendered encoding of the link, opened by the device's own camera app; no in-app scanner needed), Settings icon → Party Settings, End Party action.
- Non-host-only: Leave Party action.
- Everyone: synced playback state display (current track, progress) — read-only, sourced from the host's device over the realtime channel.

### 6. Track Search
Search Spotify's catalog (via the app-level Client Credentials token) and add a result to the party's track list. Reached from Party (Active)'s add-track button; used by host and non-host participants alike (subject to the track-adding toggle).

### 7. Party Settings (host only)
Reached from Party (Active). Edit the pin location (public parties only), toggle track-adding permission, end the party.

### 8. Host Search
Search other Spotify-authenticated users by display name. Reached from Profile tab. Clicking on one of the results open Other User Profile.

### 9. Other User Profile
Same layout as own Profile (avatar, username, top artists, current party if active, followers/following) but read-only, with a Follow/Unfollow button instead of an edit action.

### 10. Follower / Following List
Simple list, reached from either profile screen's follower/following counts. Tapping an entry opens that user's Other User Profile.

---

## Web Screens

Unauthenticated, no navbar/sign-in — reached via direct link or by browsing from Map.

### Map
Same pin data and interaction as the mobile Map tab (public parties only). Tap a pin → Party Preview. A public party's invite link opens here too, centered on that party's pin, rather than opening Party Preview directly — see Deep Links in CLAUDE.md.

### Party Preview / Party (Active)
Same states as mobile's Party Preview → Party (Active), with two differences:
- No host-only controls ever appear (a web session is never a host).
- First **Join** action (vote or add-track attempt) prompts for a guest display name (device UUID generated silently; see Guest Identity), stored for the session/device so it isn't asked again. Browsing the Preview beforehand requires no identity.

A private party's invite link opens directly here, skipping Map.
