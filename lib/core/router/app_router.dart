import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/sign_in_screen.dart';
import '../../features/map/presentation/screens/map_screen.dart';
import '../../features/party/presentation/screens/party_active_screen.dart';
import '../../features/party/presentation/screens/party_creation_screen.dart';
import '../../features/party/presentation/screens/party_preview_screen.dart';
import '../../features/party/presentation/screens/party_settings_screen.dart';
import '../../features/party/presentation/screens/party_tab_screen.dart';
import '../../features/party/presentation/screens/track_search_screen.dart';
import '../../features/profile/presentation/screens/follower_following_list_screen.dart';
import '../../features/profile/presentation/screens/host_search_screen.dart';
import '../../features/profile/presentation/screens/other_user_profile_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import 'app_routes.dart';
import 'app_shell.dart';

/// Route stubs for every screen in NAVIGATION.md so the full flow is
/// walkable end to end. Screen bodies are placeholders — only the graph and
/// bottom-chrome wiring are meant to be reviewed at this stage.
final appRouter = GoRouter(
  initialLocation: AppRoutes.signIn,
  routes: [
    GoRoute(
      path: AppRoutes.signIn,
      builder: (context, state) => const SignInScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(navigationShell: navigationShell),
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
              builder: (context, state) => const PartyTabScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.profile,
              builder: (context, state) => const ProfileScreen(),
              routes: [
                GoRoute(
                  path: 'search',
                  builder: (context, state) => const HostSearchScreen(),
                ),
              ],
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
          builder: (context, state) =>
              PartySettingsScreen(partyId: state.pathParameters['partyId']!),
        ),
        GoRoute(
          path: 'track-search',
          builder: (context, state) =>
              TrackSearchScreen(partyId: state.pathParameters['partyId']!),
        ),
      ],
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
