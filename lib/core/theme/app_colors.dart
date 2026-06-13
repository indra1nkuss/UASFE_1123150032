import 'package:flutter/material.dart';

class AppColors {
  // Premium Brutalism Palette

  // Primary: Deep Navy (Premium dark base)
  static const Color primary = Color(0xFF1A1F3A);      // Deep navy
  static const Color primaryLight = Color(0xFF2D3B5F); // Medium navy
  static const Color primaryDark = Color(0xFF0F1428);  // Very dark navy

  // Accent: Gold (Premium luxury)
  static const Color accent = Color(0xFFD4AF37);       // Gold
  static const Color accentLight = Color(0xFFE8C547);  // Light gold
  static const Color accentDark = Color(0xFFA89128);   // Dark gold

  // Semantic
  static const Color success = Color(0xFF2D5F4F);      // Deep teal
  static const Color warning = Color(0xFF8B6F47);      // Bronze
  static const Color error = Color(0xFF5F2C2C);        // Deep red
  static const Color info = Color(0xFF3A4F5F);         // Slate blue

  // Neutral: Brutalism monochrome
  static const Color ink = Color(0xFF0F1428);          // Nearly black
  static const Color charcoal = Color(0xFF2D3B4F);     // Dark gray
  static const Color slate = Color(0xFF4B5F7F);        // Medium gray
  static const Color silver = Color(0xFF9DAFBF);       // Light gray
  static const Color white = Color(0xFFFAFAFA);        // Off-white (not pure white)

  // Background
  static const Color bg = Color(0xFFF5F5F5);           // Light gray bg
  static const Color bgDark = Color(0xFF1A1F3A);       // Dark bg (same as primary)

  // Legacy support - map to new palette
  static const Color green = success;
  static const Color amber = warning;
  static const Color red = error;
  static const Color violet = info;
  static const Color slate600 = slate;
  static const Color slate500 = slate;
  static const Color slate400 = silver;
  static const Color slate300 = silver;
  static const Color line = silver;
  static const Color line2 = silver;

  // Surface colors - map to new palette for backward compatibility
  static const Color primarySurface = primary;
  static const Color primaryBorder = accent;
  static const Color greenSurface = success;
  static const Color amberSurface = warning;
  static const Color redSurface = error;
  static const Color violetSurface = info;

  // Gradients - Brutalism (solid, no gradients)
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.55, 1.0],
    colors: [primary, primary, primary],  // Solid color only
  );

  // No shadows for brutalism - replaced with stark borders
  static const List<BoxShadow> shadowCard = [];
  static const List<BoxShadow> shadowSoft = [];
  static const List<BoxShadow> shadowPrimary = [];

  // Tone map for FeatureIcon (premium colors)
  static Map<String, List<Color>> tones = {
    'blue': [primary, accent],           // Navy + Gold
    'green': [success, accentLight],     // Teal + Light Gold
    'amber': [warning, accent],          // Bronze + Gold
    'red': [error, white],               // Deep Red + White
    'violet': [info, accent],            // Slate Blue + Gold
    'slate': [charcoal, white],          // Charcoal + White
    'gold': [primary, accent],           // Navy + Gold (premium)
  };

  static List<Color> tone(String name) => tones[name] ?? tones['blue']!;

  // Premium border color for brutalism
  static const Color border = ink;                      // Stark black borders
  static const double borderWidth = 2.0;                // Thick borders
}

