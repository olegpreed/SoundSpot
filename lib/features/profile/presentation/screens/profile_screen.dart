import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../widgets/host_search_sheet.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              // Profile lives inside the Profile tab's own nested Navigator
              // (StatefulShellRoute preserves each tab's state that way).
              // That Navigator's Overlay is bounded above AppShell's
              // persistent bottomNavigationBar, so a sheet pushed onto it
              // would stop short of the bar instead of covering it. Pushing
              // onto the root Navigator instead lets the sheet overlay the
              // whole screen, bar included.
              useRootNavigator: true,
              isScrollControlled: true,
              useSafeArea: true,
              builder: (context) => const HostSearchSheet(),
            ),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Avatar, username, top artists (stub)'),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => context.push(
                AppRoutes.connectionsPath('me', followers: true),
              ),
              child: const Text('Followers / Following'),
            ),
          ],
        ),
      ),
    );
  }
}
