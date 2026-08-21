import 'package:flutter/material.dart';

/// Presented via [showModalBottomSheet] from the Party (Active) transport bar
/// (see AppShell), not as its own go_router route. A track search has no
/// state worth a URL/deep link, so a plain modal sheet — dims the party view
/// behind it, swipe-down or tap-outside to dismiss — fits better than a full
/// page.
class AddTrackSheet extends StatelessWidget {
  const AddTrackSheet({super.key, required this.partyId});

  final String partyId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Add a track', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            const TextField(
              autofocus: true,
              decoration: InputDecoration(hintText: 'Search on Spotify'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [Text('Results for party $partyId (stub)')],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
