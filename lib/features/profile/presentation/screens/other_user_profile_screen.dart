import 'package:flutter/material.dart';

class OtherUserProfileScreen extends StatelessWidget {
  const OtherUserProfileScreen({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile ($userId)')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Avatar, username, top artists (stub, read-only)'),
            const SizedBox(height: 16),
            OutlinedButton(onPressed: () {}, child: const Text('Follow')),
          ],
        ),
      ),
    );
  }
}
