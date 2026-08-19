import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/party_preview_bottom_bar.dart';

class PartyPreviewScreen extends StatelessWidget {
  const PartyPreviewScreen({super.key, required this.partyId});

  final String partyId;

  @override
  Widget build(BuildContext context) {
    final canGoBack = context.canPop();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Party Preview ($partyId)'),
      ),
      body: const Center(child: Text('Read-only track list (stub)')),
      bottomNavigationBar: PartyPreviewBottomBar(
        onBack: canGoBack ? () => context.pop() : null,
        onJoin: () => context.go(AppRoutes.partyActivePath(partyId)),
      ),
    );
  }
}
