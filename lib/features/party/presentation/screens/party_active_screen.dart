import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/party_active_bottom_bar.dart';

/// isHost/isPlaying/canAddTrack are local stub state until the party
/// repository and realtime playback stream exist.
class PartyActiveScreen extends StatefulWidget {
  const PartyActiveScreen({super.key, required this.partyId});

  final String partyId;

  @override
  State<PartyActiveScreen> createState() => _PartyActiveScreenState();
}

class _PartyActiveScreenState extends State<PartyActiveScreen> {
  bool _isHost = true;
  bool _isPlaying = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Party (${widget.partyId})'),
        actions: [
          if (_isHost)
            IconButton(
              onPressed: () =>
                  context.push(AppRoutes.partySettingsPath(widget.partyId)),
              icon: const Icon(Icons.settings_outlined),
            ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_isHost ? 'Viewing as host' : 'Viewing as guest'),
            TextButton(
              onPressed: () => setState(() => _isHost = !_isHost),
              child: const Text('Toggle host/guest (stub)'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: PartyActiveBottomBar(
        isHost: _isHost,
        isPlaying: _isPlaying,
        canAddTrack: true,
        onBack: () =>
            context.canPop() ? context.pop() : context.go(AppRoutes.map),
        onPlayPause: () => setState(() => _isPlaying = !_isPlaying),
        onAddTrack: () =>
            context.push(AppRoutes.trackSearchPath(widget.partyId)),
      ),
    );
  }
}
