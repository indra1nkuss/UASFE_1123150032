import 'package:flutter/material.dart';

class AppColors {
  // Premium Brutalism Palette - UPDATED FOR BETTER CONTRAST & BRIGHTNESS

  // Primary: Charcoal (darker but not black - better contrast)
  static const Color primary = Color(0xFF2C3E50);      // Charcoal
  static const Color primaryLight = Color(0xFF34495E); // Medium charcoal
  static const Color primaryDark = Color(0xFF1A252F);  // Dark charcoal

  // Accent: Vibrant Gold (brighter, more attention-grabbing)
  static const Color accent = Color(0xFFFFD700);       // Bright gold
  static const Color accentLight = Color(0xFFFFF44F);  // Lighter gold
  static const Color accentDark = Color(0xFFFFC700);   // Darker gold

  // Semantic - BRIGHTER VERSIONS
  static const Color success = Color(0xFF27AE60);      // Bright emerald green
  static const Color warning = Color(0xFFF39C12);      // Bright orange/amber
  static const Color error = Color(0xFFE74C3C);        // Bright red
  static const Color info = Color(0xFF3498DB);         // Bright blue

  // Neutral: Better contrast
  static const Color ink = Color(0xFF1A1A1A);          // Almost black (not pure black)
  static const Color charcoal = Color(0xFF2C3E50);     // Dark charcoal
  static const Color slate = Color(0xFF7F8C8D);        // Medium gray
  static const Color silver = Color(0xFFBDC3C7);       // Light gray
  static const Color white = Color(0xFFFFFFFF);        // Pure white

  // Background - BRIGHT & CLEAN
  static const Color bg = Color(0xFFFAFBFC);           // Off-white (very light)
  static const Color bgDark = Color(0xFF2C3E50);       // Dark bg (charcoal)

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

  // Surface colors - BRIGHT VERSIONS
  static const Color primarySurface = Color(0xFFECF0F1);   // Very light gray (not primary color)
  static const Color primaryBorder = accent;
  static const Color greenSurface = Color(0xFFD5F4E6);     // Light green
  static const Color amberSurface = Color(0xFFFEEDD2);     // Light orange
  static const Color redSurface = Color(0xFFFFDCCE);       // Light red
  static const Color violetSurface = Color(0xFFEBF5FB);    // Light blue

  // Gradients - Brutalism (solid, no gradients)
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.55, 1.0],
    colors: [primary, primary, primary],  // Solid color only
  );

  // No shadows for brutalism
  static const List<BoxShadow> shadowCard = [];
  static const List<BoxShadow> shadowSoft = [];
  static const List<BoxShadow> shadowPrimary = [];

  // Tone map for FeatureIcon
  static Map<String, List<Color>> tones = {
    'blue': [primarySurface, info],            // Light gray + Bright blue
    'green': [greenSurface, success],          // Light green + Bright green
    'amber': [amberSurface, warning],          // Light orange + Bright orange
    'red': [redSurface, error],                // Light red + Bright red
    'violet': [violetSurface, info],           // Light blue + Bright blue
    'slate': [primarySurface, slate],          // Light gray + Medium gray
    'gold': [primarySurface, accent],          // Light gray + Bright gold
  };

  static List<Color> tone(String name) => tones[name] ?? tones['blue']!;

  // Premium border color for brutalism
  static const Color border = charcoal;                  // Dark borders for stark look
  static const double borderWidth = 2.0;                // Thick borders
}
