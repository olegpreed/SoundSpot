import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';

class HostSearchScreen extends StatelessWidget {
  const HostSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Hosts')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(hintText: 'Search by display name'),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () =>
                  context.push(AppRoutes.otherUserProfilePath('demo-user')),
              child: const Text('Open a result (stub)'),
            ),
          ],
        ),
      ),
    );
  }
}
