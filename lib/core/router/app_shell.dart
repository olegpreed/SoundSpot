import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/party/application/active_party_provider.dart';
import '../../features/party/presentation/widgets/add_track_sheet.dart';
import '../widgets/main_bottom_nav_bar.dart';
import '../widgets/party_active_bottom_bar.dart';
import '../widgets/party_preview_bottom_bar.dart';
import 'app_routes.dart';

enum _BarVariant { mainTabs, partyPreview, partyActive }

/// Persistent outer chrome shared by Main (Map/Party/Profile), Party Preview
/// and Party (Active) — see app_router.dart. This widget stays mounted
/// across all three; only the bottom bar's content cross-fades between
/// variants (see NAVIGATION.md's Bottom Chrome section) while page content
/// still gets go_router's normal push/pop transition underneath it. Party
/// Settings intentionally escapes this shell entirely (parentNavigatorKey in
/// app_router.dart) to overlay full-screen with no bar at all, rather than
/// cross-fading to an empty state. Add Track is a modal bottom sheet shown
/// directly over this shell instead — see onAddTrack below.
///
/// isHost/isPlaying/canAddTrack are hardcoded stub values until the party
/// repository and realtime playback stream exist — [activePartyProvider]
/// only tracks *which* party is active, not host role or playback state.
class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.state, required this.child});

  final GoRouterState state;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final path = state.uri.path;
    final variant = _variantFor(path);
    final hasActiveParty = ref.watch(activePartyProvider) != null;

    return Scaffold(
      body: child,
      bottomNavigationBar: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (child, animation) =>
            FadeTransition(opacity: animation, child: child),
        child: KeyedSubtree(
          key: ValueKey(variant),
          child: _barFor(context, ref, variant, path, hasActiveParty),
        ),
      ),
    );
  }

  _BarVariant _variantFor(String path) {
    if (path.startsWith('/party/preview/')) return _BarVariant.partyPreview;
    if (path.startsWith('/party/active/')) return _BarVariant.partyActive;
    return _BarVariant.mainTabs;
  }

  Widget _barFor(
    BuildContext context,
    WidgetRef ref,
    _BarVariant variant,
    String path,
    bool hasActiveParty,
  ) {
    switch (variant) {
      case _BarVariant.mainTabs:
        return MainBottomNavBar(
          currentIndex: _mainTabIndex(path),
          hasActiveParty: hasActiveParty,
          isPlaying: true,
          onTogglePlay: () {},
          onTap: (index) => context.go(_mainTabPath(index)),
        );
      case _BarVariant.partyPreview:
        final partyId = _partyIdFrom(path);
        final canGoBack = state.extra == true;
        return PartyPreviewBottomBar(
          onBack: canGoBack ? () => context.pop() : null,
          onJoin: () {
            ref.read(activePartyProvider.notifier).set(partyId);
            context.go(AppRoutes.partyActivePath(partyId));
          },
        );
      case _BarVariant.partyActive:
        final partyId = _partyIdFrom(path);
        final canGoBack = state.extra == true;
        return PartyActiveBottomBar(
          isHost: true,
          isPlaying: true,
          canAddTrack: true,
          onBack: () => canGoBack ? context.pop() : context.go(AppRoutes.map),
          onPlayPause: () {},
          onAddTrack: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            builder: (context) => AddTrackSheet(partyId: partyId),
          ),
        );
    }
  }

  int _mainTabIndex(String path) {
    if (path.startsWith(AppRoutes.party)) return 1;
    if (path.startsWith(AppRoutes.profile)) return 2;
    return 0;
  }

  String _mainTabPath(int index) => switch (index) {
    1 => AppRoutes.party,
    2 => AppRoutes.profile,
    _ => AppRoutes.map,
  };

  String _partyIdFrom(String path) {
    final segments = path.split('/').where((s) => s.isNotEmpty).toList();
    final marker = segments.contains('preview') ? 'preview' : 'active';
    final index = segments.indexOf(marker);
    return index != -1 && index + 1 < segments.length
        ? segments[index + 1]
        : '';
  }
}
