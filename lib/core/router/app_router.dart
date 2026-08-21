import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/sign_in_screen.dart';
import '../../features/party/application/active_party_provider.dart';
import '../../features/map/presentation/screens/map_screen.dart';
import '../../features/party/presentation/screens/party_active_screen.dart';
import '../../features/party/presentation/screens/party_creation_screen.dart';
import '../../features/party/presentation/screens/party_preview_screen.dart';
import '../../features/party/presentation/screens/party_settings_screen.dart';
import '../../features/party/presentation/screens/party_tab_screen.dart';
import '../../features/profile/presentation/screens/follower_following_list_screen.dart';
import '../../features/profile/presentation/screens/other_user_profile_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import 'app_routes.dart';
import 'app_shell.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

/// Route stubs for every screen in NAVIGATION.md so the full flow is
/// walkable end to end. Screen bodies are placeholders — only the graph and
/// bottom-chrome wiring are meant to be reviewed at this stage.
///
/// Map / Party / Profile / Party Preview / Party (Active) share one
/// persistent AppShell (see app_shell.dart) so the bottom bar stays mounted
/// and only cross-fades its content between those contexts, instead of
/// re-transitioning along with the page. Party Settings uses
/// [GoRoute.parentNavigatorKey] to escape that shell and cover the full
/// screen with no bar — see NAVIGATION.md's Bottom Chrome section. Add Track
/// and Host Search are both modal bottom sheets triggered directly from
/// their respective screens (see AppShell and profile_screen.dart) rather
/// than routes at all. Every other route (Sign In, Party Creation, profiles)
/// is a plain top-level route outside the shell, so it never shows the bar
/// either.
///
/// Map/Party/Profile are additionally nested in their own
/// [StatefulShellRoute] inside the outer shell: switching between them uses
/// its IndexedStack, which preserves each tab's own state (e.g. Map's
/// camera position) and swaps instantly with no page transition, unlike
/// pushing into Preview/Active/Settings, which still gets go_router's normal
/// transition — "slide only when going deep."
///
/// The Party tab's own route redirects straight to Party (Active) whenever
/// [activePartyProvider] is set — the tab itself only ever renders the
/// "create a party" empty state; there's no intermediate "you have a party,
/// tap to open it" screen.
final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.signIn,
  routes: [
    GoRoute(
      path: AppRoutes.signIn,
      builder: (context, state) => const SignInScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => AppShell(state: state, child: child),
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) => navigationShell,
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.map,
                  builder: (context, state) => const MapScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.party,
                  redirect: (context, state) {
                    final activePartyId = ProviderScope.containerOf(
                      context,
                      listen: false,
                    ).read(activePartyProvider);
                    return activePartyId == null
                        ? null
                        : AppRoutes.partyActivePath(activePartyId);
                  },
                  builder: (context, state) => const PartyTabScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.profile,
                  builder: (context, state) => const ProfileScreen(),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.partyPreview,
          builder: (context, state) =>
              PartyPreviewScreen(partyId: state.pathParameters['partyId']!),
        ),
        GoRoute(
          path: AppRoutes.partyActive,
          builder: (context, state) =>
              PartyActiveScreen(partyId: state.pathParameters['partyId']!),
          routes: [
            GoRoute(
              path: 'settings',
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) => PartySettingsScreen(
                partyId: state.pathParameters['partyId']!,
              ),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.partyCreate,
      builder: (context, state) => const PartyCreationScreen(),
    ),
    GoRoute(
      path: AppRoutes.otherUserProfile,
      builder: (context, state) =>
          OtherUserProfileScreen(userId: state.pathParameters['userId']!),
      routes: [
        GoRoute(
          path: 'connections',
          builder: (context, state) => FollowerFollowingListScreen(
            userId: state.pathParameters['userId']!,
            showFollowers: state.uri.queryParameters['type'] != 'following',
          ),
        ),
      ],
    ),
  ],
);
