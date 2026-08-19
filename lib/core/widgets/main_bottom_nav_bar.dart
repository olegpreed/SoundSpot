import 'package:flutter/material.dart';

/// The 3-tab bar for Map / Party / Profile. The center (Party) icon is
/// contextual — a plain "+" with no active party, or a play/pause toggle
/// once the user has one ("playlist mode") — see NAVIGATION.md's Bottom
/// Chrome section.
class MainBottomNavBar extends StatelessWidget {
  const MainBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.hasActiveParty = false,
    this.isPlaying = false,
    this.onTogglePlay,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool hasActiveParty;
  final bool isPlaying;
  final VoidCallback? onTogglePlay;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BottomAppBar(
      color: Colors.black,
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _NavIconButton(
            icon: Icons.location_on_outlined,
            label: 'Map',
            selected: currentIndex == 0,
            onPressed: () => onTap(0),
          ),
          _NavIconButton(
            icon: hasActiveParty
                ? (isPlaying ? Icons.pause : Icons.play_arrow)
                : Icons.add,
            label: hasActiveParty
                ? (isPlaying ? 'Pause' : 'Play')
                : 'Create party',
            selected: currentIndex == 1,
            filled: hasActiveParty,
            color: colorScheme.primary,
            onPressed: () {
              if (hasActiveParty && currentIndex == 1) {
                onTogglePlay?.call();
              } else {
                onTap(1);
              }
            },
          ),
          _NavIconButton(
            icon: Icons.person_outline,
            label: 'Profile',
            selected: currentIndex == 2,
            onPressed: () => onTap(2),
          ),
        ],
      ),
    );
  }
}

class _NavIconButton extends StatelessWidget {
  const _NavIconButton({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onPressed,
    this.filled = false,
    this.color,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final bool filled;
  final Color? color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final accent = color ?? Theme.of(context).colorScheme.primary;
    final iconColor = filled
        ? Colors.black
        : (selected ? accent : Colors.white70);

    return IconButton(
      onPressed: onPressed,
      tooltip: label,
      icon: Icon(icon, color: iconColor),
      style: filled
          ? IconButton.styleFrom(backgroundColor: accent)
          : IconButton.styleFrom(),
    );
  }
}
