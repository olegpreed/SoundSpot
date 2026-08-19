import 'package:flutter/material.dart';

/// Single source of truth for the app's accent color. All tonal shades and
/// opacity variants should be derived from this seed via [ColorScheme.fromSeed]
/// rather than hardcoded elsewhere.
class AppColors {
  const AppColors._();

  static const Color seed = Color(0xFFAEEA00);
  static const Color background = Color(0xFF0A0A0A);
  static const Color surface = Color(0xFF161616);
  static const Color upvote = Color(0xFFAEEA00);
  static const Color downvote = Color(0xFFFF3B5C);
}
