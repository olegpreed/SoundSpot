import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../application/active_party_provider.dart';

/// The Party tab only ever renders the "no active party" empty state — when
/// [activePartyProvider] is set, the route itself redirects straight to
/// Party (Active) before this ever builds (see app_router.dart), so there's
/// no "you have a party, tap to open it" middleman screen here.
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
