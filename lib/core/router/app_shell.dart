import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/main_bottom_nav_bar.dart';

/// Hosts the Map / Party / Profile tabs. Party Preview, Party (Active),
/// Track Search, Party Settings and the creation wizard are pushed as
/// top-level routes outside this shell, each with their own bottom chrome
/// (see NAVIGATION.md's Bottom Chrome section) rather than living here.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: MainBottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}
