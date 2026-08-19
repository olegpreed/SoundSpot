import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';

/// Stub: public party pins go here once map/location work begins. Tapping a
/// pin navigates to Party Preview with that party's id.
class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      body: Center(
        child: OutlinedButton(
          onPressed: () =>
              context.push(AppRoutes.partyPreviewPath('demo-party')),
          child: const Text('Open a pin (stub)'),
        ),
      ),
    );
  }
}
