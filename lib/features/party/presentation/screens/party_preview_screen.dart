import 'package:flutter/material.dart';

/// The bottom bar for this screen is owned by AppShell (see app_shell.dart),
/// not this widget — it's part of the persistent chrome shared with Party
/// (Active) and Main, not this screen's own Scaffold.
class PartyPreviewScreen extends StatelessWidget {
  const PartyPreviewScreen({super.key, required this.partyId});

  final String partyId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Party Preview ($partyId)'),
      ),
      body: const Center(child: Text('Read-only track list (stub)')),
    );
  }
}
