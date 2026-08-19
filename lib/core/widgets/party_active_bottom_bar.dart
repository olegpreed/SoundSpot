import 'package:flutter/material.dart';

/// Bottom chrome for the Party (Active) screen — replaces the main tab bar
/// entirely. The left control is app back-navigation (not a playback
/// transport control), available to host and guest alike. Only the center
/// play/pause reflects playback authority: only the host's device drives
/// playback (see CLAUDE.md's Spotify Integration rules), so [isHost]
/// disables it for guests rather than hiding it, keeping the synced
/// playback state visible either way.
class PartyActiveBottomBar extends StatelessWidget {
  const PartyActiveBottomBar({
    super.key,
    required this.isHost,
    required this.isPlaying,
    required this.canAddTrack,
    required this.onBack,
    this.onPlayPause,
    this.onAddTrack,
  });

  final bool isHost;
  final bool isPlaying;
  final bool canAddTrack;
  final VoidCallback onBack;
  final VoidCallback? onPlayPause;
  final VoidCallback? onAddTrack;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BottomAppBar(
      color: Colors.black,
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: onBack,
            tooltip: 'Back',
            icon: const Icon(Icons.arrow_back),
            color: Colors.white70,
          ),
          IconButton(
            onPressed: isHost ? onPlayPause : null,
            tooltip: isPlaying ? 'Pause' : 'Play',
            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
            style: IconButton.styleFrom(
              backgroundColor: isHost ? colorScheme.primary : Colors.white24,
            ),
            color: Colors.black,
          ),
          IconButton(
            onPressed: canAddTrack ? onAddTrack : null,
            tooltip: 'Add track',
            icon: const Icon(Icons.add_circle_outline),
            color: canAddTrack ? Colors.white70 : Colors.white24,
          ),
        ],
      ),
    );
  }
}
