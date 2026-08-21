import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';

/// Stub: public party pins go here once map/location work begins. `extra:
/// true` tells AppShell's bottom bar there's a screen to pop back to —
/// go_router's canPop doesn't reliably reflect that across a
/// StatefulShellRoute branch boundary, so it's signaled explicitly instead.
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
