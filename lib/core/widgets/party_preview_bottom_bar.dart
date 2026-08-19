import 'package:flutter/material.dart';

/// Bottom chrome for the Party Preview screen — just Back + Join, since the
/// user hasn't joined the party yet and no transport controls apply. [onBack]
/// is null when there's nowhere to go back to — e.g. a private party's
/// invite link opens directly here with no prior screen in the stack (see
/// CLAUDE.md's Deep Links rules) — in which case the back button is omitted
/// entirely rather than shown disabled.
class PartyPreviewBottomBar extends StatelessWidget {
  const PartyPreviewBottomBar({
    super.key,
    required this.onBack,
    required this.onJoin,
    this.joinEnabled = true,
  });

  final VoidCallback? onBack;
  final VoidCallback onJoin;
  final bool joinEnabled;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          if (onBack != null)
            IconButton(
              onPressed: onBack,
              tooltip: 'Back',
              icon: const Icon(Icons.arrow_back, color: Colors.white70),
            ),
          const Spacer(),
          FilledButton(
            onPressed: joinEnabled ? onJoin : null,
            style: FilledButton.styleFrom(minimumSize: const Size(96, 44)),
            child: const Text('Join'),
          ),
        ],
      ),
    );
  }
}
