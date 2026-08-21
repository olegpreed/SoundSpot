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

/// See NAVIGATION.md for the full screen inventory and flow.
///
/// Map/Party/Profile are nested in a [StatefulShellRoute]: switching between
/// them uses its IndexedStack, which preserves each tab's state and swaps
/// instantly with no page transition — unlike pushing into
/// Preview/Active/Settings, which still gets go_router's normal transition.
///
/// The Party tab's own route redirects straight to Party (Active) whenever
/// [activePartyProvider] is set, so there's no intermediate "tap to open
/// your party" screen.
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
