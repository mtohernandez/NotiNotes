import 'package:flutter/material.dart';

/// A swatch in the curated palette used for per-note backgrounds.
/// Each swatch carries a paired dark-mode tint and an auto-contrast text color.
class NotesSwatch {
  final String name;
  final Color light;
  final Color dark;

  const NotesSwatch({
    required this.name,
    required this.light,
    required this.dark,
  });

  /// Returns the swatch color appropriate for the current brightness.
  Color background(Brightness brightness) =>
      brightness == Brightness.dark ? dark : light;

  /// Auto-contrast text color computed from luminance.
  /// Cards stay legible without the user picking a font color.
  Color autoTextColor(Brightness brightness) {
    final bg = background(brightness);
    return bg.computeLuminance() > 0.5
        ? const Color(0xFF1A1A1A)
        : const Color(0xFFF5F5F5);
  }
}

/// 12 curated pastel swatches. Light values are warm and saturated enough to
/// look distinct in a 2-column masonry grid. Dark values are at ~22% lightness
/// so they read as muted color tints rather than full bright fills.
class NotesColorPalette {
  NotesColorPalette._();

  static const List<NotesSwatch> swatches = [
    NotesSwatch(
      name: 'Yellow',
      light: Color(0xFFFFF4B8),
      dark: Color(0xFF3A3520),
    ),
    NotesSwatch(
      name: 'Peach',
      light: Color(0xFFFFD9B8),
      dark: Color(0xFF3A2C20),
    ),
    NotesSwatch(
      name: 'Rose',
      light: Color(0xFFFFC4C4),
      dark: Color(0xFF3A2424),
    ),
    NotesSwatch(
      name: 'Lilac',
      light: Color(0xFFF4C4FF),
      dark: Color(0xFF35243A),
    ),
    NotesSwatch(
      name: 'Periwinkle',
      light: Color(0xFFC4D4FF),
      dark: Color(0xFF24293A),
    ),
    NotesSwatch(
      name: 'Sky',
      light: Color(0xFFC4ECFF),
      dark: Color(0xFF20323A),
    ),
    NotesSwatch(
      name: 'Mint',
      light: Color(0xFFC4FFE4),
      dark: Color(0xFF20382C),
    ),
    NotesSwatch(
      name: 'Lime',
      light: Color(0xFFE4FFC4),
      dark: Color(0xFF2C3820),
    ),
    NotesSwatch(
      name: 'Sand',
      light: Color(0xFFF0E4D4),
      dark: Color(0xFF332E26),
    ),
    NotesSwatch(
      name: 'Olive',
      light: Color(0xFFE4DCC4),
      dark: Color(0xFF2E2C20),
    ),
    NotesSwatch(
      name: 'Stone',
      light: Color(0xFFD4D4D4),
      dark: Color(0xFF2A2A2A),
    ),
    NotesSwatch(
      name: 'Paper',
      light: Color(0xFFFFFFFF),
      dark: Color(0xFF1F1F1F),
    ),
  ];

  /// The default swatch used for newly created notes.
  static const NotesSwatch defaultSwatch = NotesSwatch(
    name: 'Paper',
    light: Color(0xFFFFFFFF),
    dark: Color(0xFF1F1F1F),
  );

  /// Find a swatch by its background color (light or dark).
  /// Returns [defaultSwatch] if no match.
  static NotesSwatch? swatchFor(Color color) {
    for (final s in swatches) {
      if (s.light.toARGB32() == color.toARGB32() ||
          s.dark.toARGB32() == color.toARGB32()) {
        return s;
      }
    }
    return null;
  }
}

/// 8 curated gradient presets. The selection in the Style sheet replaces the
/// per-note solid color and pattern when active.
class NotesGradientPalette {
  NotesGradientPalette._();

  static const List<LinearGradient> gradients = [
    LinearGradient(
      colors: [Color(0xFFFFB6B6), Color(0xFFFFD6A5)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    LinearGradient(
      colors: [Color(0xFFC4D4FF), Color(0xFFF4C4FF)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    LinearGradient(
      colors: [Color(0xFFC4FFE4), Color(0xFFC4ECFF)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    LinearGradient(
      colors: [Color(0xFFFFF4B8), Color(0xFFFFD9B8)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    LinearGradient(
      colors: [Color(0xFFE4DCC4), Color(0xFFD4D4D4)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    LinearGradient(
      colors: [Color(0xFF2C3E50), Color(0xFF4CA1AF)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    LinearGradient(
      colors: [Color(0xFF614385), Color(0xFF516395)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    LinearGradient(
      colors: [Color(0xFFFF6E7F), Color(0xFFBFE9FF)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ];
}

/// 8 text color swatches for the optional per-note text color override.
/// "Auto" is represented by null and uses the swatch's autoTextColor.
class NotesTextColorPalette {
  NotesTextColorPalette._();

  static const List<Color> colors = [
    Color(0xFF1A1A1A),
    Color(0xFFF5F5F5),
    Color(0xFFB91C1C),
    Color(0xFFB45309),
    Color(0xFF15803D),
    Color(0xFF1D4ED8),
    Color(0xFF6D28D9),
    Color(0xFFBE185D),
  ];
}
