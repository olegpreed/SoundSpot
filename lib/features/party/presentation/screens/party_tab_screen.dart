import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';

/// Stub for the Party tab. Real "is the user active in a party" state comes
/// from the party repository once it exists; this local toggle stands in for
/// it so both states are reviewable.
class PartyTabScreen extends StatefulWidget {
  const PartyTabScreen({super.key});

  @override
  State<PartyTabScreen> createState() => _PartyTabScreenState();
}

class _PartyTabScreenState extends State<PartyTabScreen> {
  bool _hasActiveParty = false;

  @override
  Widget build(BuildContext context) {
    if (_hasActiveParty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Party'),
          actions: [
            IconButton(
              onPressed: () => setState(() => _hasActiveParty = false),
              icon: const Icon(Icons.close),
              tooltip: 'Leave (stub)',
            ),
          ],
        ),
        body: Center(
          child: OutlinedButton(
            onPressed: () =>
                context.push(AppRoutes.partyActivePath('demo-party')),
            child: const Text('View active party (stub)'),
          ),
        ),
      );
    }

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
              onPressed: () => setState(() => _hasActiveParty = true),
              child: const Text('Simulate active party (stub)'),
            ),
          ],
        ),
      ),
    );
  }
}
