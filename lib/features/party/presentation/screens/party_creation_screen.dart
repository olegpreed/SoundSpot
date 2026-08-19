import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';

/// Stub for the 3-step creation wizard (name → visibility/pin/toggle →
/// playlist seeding). Steps aren't split out yet — this placeholder just
/// completes the flow so the rest of the navigation graph is walkable.
class PartyCreationScreen extends StatelessWidget {
  const PartyCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Party')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Step 1: Name · Step 2: Visibility & pin · Step 3: Playlist seeding',
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () =>
                    context.go(AppRoutes.partyActivePath('demo-party')),
                child: const Text('Finish (stub) → Party Active'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
