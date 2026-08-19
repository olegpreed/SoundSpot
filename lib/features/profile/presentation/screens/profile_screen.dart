import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () => context.push(AppRoutes.hostSearch),
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
