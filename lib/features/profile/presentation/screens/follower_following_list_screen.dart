import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';

class FollowerFollowingListScreen extends StatelessWidget {
  const FollowerFollowingListScreen({
    super.key,
    required this.userId,
    required this.showFollowers,
  });

  final String userId;
  final bool showFollowers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(showFollowers ? 'Followers' : 'Following')),
      body: Center(
        child: OutlinedButton(
          onPressed: () =>
              context.push(AppRoutes.otherUserProfilePath('demo-user')),
          child: const Text('Open an entry (stub)'),
        ),
      ),
    );
  }
}
