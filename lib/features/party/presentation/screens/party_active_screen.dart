import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../application/active_party_provider.dart';

/// The bottom bar for this screen is owned by AppShell (see app_shell.dart),
/// not this widget — it's part of the persistent chrome shared with Party
/// Preview and Main, not this screen's own Scaffold.
class PartyActiveScreen extends ConsumerWidget {
  const PartyActiveScreen({super.key, required this.partyId});

  final String partyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Party ($partyId)'),
        actions: [
          IconButton(
            onPressed: () => context.push(AppRoutes.partySettingsPath(partyId)),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Track list (stub)'),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                ref.read(activePartyProvider.notifier).clear();
                context.go(AppRoutes.party);
              },
              child: const Text('Leave / End Party (stub)'),
            ),
          ],
        ),
      ),
    );
  }
}
