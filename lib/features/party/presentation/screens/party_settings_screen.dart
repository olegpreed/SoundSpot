import 'package:flutter/material.dart';

class PartySettingsScreen extends StatelessWidget {
  const PartySettingsScreen({super.key, required this.partyId});

  final String partyId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Party Settings')),
      body: Center(
        child: Text('Edit pin, track-adding toggle, end party ($partyId)'),
      ),
    );
  }
}
