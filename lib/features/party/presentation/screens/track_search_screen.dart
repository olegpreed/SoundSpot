import 'package:flutter/material.dart';

class TrackSearchScreen extends StatelessWidget {
  const TrackSearchScreen({super.key, required this.partyId});

  final String partyId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a song')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(hintText: 'Search on Spotify'),
            ),
            const SizedBox(height: 16),
            Text('Results for party $partyId (stub)'),
          ],
        ),
      ),
    );
  }
}
