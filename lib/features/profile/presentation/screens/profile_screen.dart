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
              // Profile's tab Navigator doesn't reach past the bottom bar;
              // use the root Navigator so the sheet covers it too.
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
