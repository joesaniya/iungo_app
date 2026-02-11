import 'package:flutter/material.dart';

/// Centralized color constants for the application
/// Works alongside existing AppTheme - use these for new code or when refactoring
/// This allows gradual migration without breaking existing code
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // Base colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Neutral colors - replaces hardcoded grays throughout the app
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral200 = Color(0xFFE0E0E0);
  static const Color neutral400 = Color(0xFF9E9E9E);
  static const Color neutral600 = Color(0xFF666666);
  static const Color neutral900 = Color(0xFF333333);

  // Primary brand colors - use these instead of hardcoded values
  static const Color primaryPurple = Color(0xFF5D2E5F); // Main button & brand color
  static const Color primaryRed = Color(0xFFC62828);    // Logo red

  // Purple palette
  static const Color purple100 = Color(0xFFE1BEE7);
  static const Color purple700 = Color(0xFF7B1FA2);
  static const Color purple900 = Color(0xFF4A148C);

  // Blue palette
  static const Color blue100 = Color(0xFFBBDEFB);
  static const Color blue300 = Color(0xFF64B5F6);
  static const Color blue500 = Color(0xFF2196F3);
  static const Color blue700 = Color(0xFF1976D2);
  static const Color blue900 = Color(0xFF0D47A1);

  // Teal/Green-Blue - used in charts and cards
  static const Color teal = Color(0xFF66B29B);

  // Green palette
  static const Color green100 = Color(0xFFC8E6C9);
  static const Color green500 = Color(0xFF4CAF50);
  static const Color green700 = Color(0xFF388E3C);

  // Red palette
  static const Color red100 = Color(0xFFFFCDD2);
  static const Color red300 = Color(0xFFE57373);
  static const Color red700 = Color(0xFFD32F2F);
  static const Color red900 = Color(0xFFB71C1C);

  // Yellow palette
  static const Color yellow600 = Color(0xFFFDD835);

  // Semantic colors - use these for consistent messaging
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF81C784);
  static const Color warning = Color(0xFFFDD835);
  static const Color info = Color(0xFF2196F3);

  // Text colors - replaces hardcoded text colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textDisabled = Color(0xFF9E9E9E);

  // Border colors - use for consistent borders
  static const Color border = Color(0xFFE0E0E0);

  // Background colors
  static const Color background = Color(0xFFFFFFFF);
  static const Color backgroundLight = Color(0xFFF5F5F5);

  // Component-specific colors
  static const Color mapButtonBackground = Color(0xFF6B7C93);
  static const Color comingSoonBadge = Color(0xFF81C784);

  // Chart colors - use these in all charts for consistency
  static const Color chartPurple = Color(0xFF7B1FA2);
  static const Color chartPurpleLight = Color(0xFFE1BEE7);
  static const Color chartRed = Color(0xFFD32F2F);
  static const Color chartRedLight = Color(0xFFFFCDD2);
  static const Color chartGreen = Color(0xFF388E3C);
  static const Color chartGreenLight = Color(0xFFC8E6C9);
  static const Color chartBlue = Color(0xFF3F79AD);
  static const Color chartTeal = Color(0xFF66B29B);
  static const Color chartGray = Color(0xFF9E9E9E);

  // Shadow colors with opacity
  static Color shadow9 = Colors.black.withOpacity(0.09);
  static Color shadow17 = Colors.black.withOpacity(0.17);
}