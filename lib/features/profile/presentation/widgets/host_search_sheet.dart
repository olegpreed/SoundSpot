import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';

/// Presented via [showModalBottomSheet] from Profile's search action, not as
/// its own go_router route — same treatment as Add Track.
class HostSearchSheet extends StatelessWidget {
  const HostSearchSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Search Hosts', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            const TextField(
              autofocus: true,
              decoration: InputDecoration(hintText: 'Search by display name'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Open a result (stub)'),
                    onTap: () {
                      Navigator.of(context).pop();
                      context.push(AppRoutes.otherUserProfilePath('demo-user'));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
