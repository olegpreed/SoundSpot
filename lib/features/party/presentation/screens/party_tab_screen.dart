import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../application/active_party_provider.dart';

/// Only ever renders the "no active party" empty state — the route itself
/// redirects to Party (Active) before this builds when a party is active
/// (see app_router.dart).
class PartyTabScreen extends ConsumerWidget {
  const PartyTabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Party')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("You're not in a party right now."),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => context.push(AppRoutes.partyCreate),
              child: const Text('Create Party'),
            ),
            TextButton(
              onPressed: () {
                ref.read(activePartyProvider.notifier).set('demo-party');
                context.go(AppRoutes.party);
              },
              child: const Text('Simulate active party (stub)'),
            ),
          ],
        ),
      ),
    );
  }
}
