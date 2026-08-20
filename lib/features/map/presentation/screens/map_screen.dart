import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';

/// Stub: public party pins go here once map/location work begins. Tapping a
/// pin navigates to Party Preview with that party's id. `extra: true` tells
/// AppShell's bottom bar there's a real screen to pop back to (see
/// app_shell.dart) — go_router's own canPop tracking doesn't reliably
/// reflect this once a push crosses from a nested StatefulShellRoute branch
/// into a sibling route outside it, so back-availability is signaled
/// explicitly at each call site instead of inferred from router internals.
class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      body: Center(
        child: OutlinedButton(
          onPressed: () => context.push(
            AppRoutes.partyPreviewPath('demo-party'),
            extra: true,
          ),
          child: const Text('Open a pin (stub)'),
        ),
      ),
    );
  }
}
