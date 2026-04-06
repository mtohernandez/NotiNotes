import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Curated writing fonts the user can pick in Settings. Inter is the default
/// because it renders crisply on Android and iOS at small body sizes.
enum WritingFont {
  inter('Inter'),
  lora('Lora'),
  newsreader('Newsreader'),
  jetBrainsMono('JetBrains Mono'),
  sourceSerif('Source Serif 4');

  final String googleFontName;
  const WritingFont(this.googleFontName);

  String get displayName {
    switch (this) {
      case WritingFont.inter:
        return 'Inter';
      case WritingFont.lora:
        return 'Lora';
      case WritingFont.newsreader:
        return 'Newsreader';
      case WritingFont.jetBrainsMono:
        return 'JetBrains Mono';
      case WritingFont.sourceSerif:
        return 'Source Serif';
    }
  }

  TextStyle get sample => GoogleFonts.getFont(googleFontName);
}

/// Builds the app TextTheme using a chosen writing font for body styles.
/// Display/title use Inter consistently so chrome stays uniform across font
/// picks; only the editor body and card preview switch fonts.
class AppTypography {
  AppTypography._();

  static TextTheme buildTextTheme({
    required Brightness brightness,
    required WritingFont writingFont,
  }) {
    final onSurface =
        brightness == Brightness.dark ? Colors.white : const Color(0xFF1A1A1A);
    final onSurfaceMuted = onSurface.withValues(alpha: 0.6);

    final chromeFont = GoogleFonts.interTextTheme();
    final bodyFont = GoogleFonts.getTextTheme(writingFont.googleFontName);

    return TextTheme(
      // Editor title
      displayLarge: chromeFont.displayLarge?.copyWith(
        fontSize: 28,
        height: 34 / 28,
        fontWeight: FontWeight.w600,
        color: onSurface,
        letterSpacing: -0.5,
      ),
      displayMedium: chromeFont.displayMedium?.copyWith(
        fontSize: 24,
        height: 30 / 24,
        fontWeight: FontWeight.w600,
        color: onSurface,
        letterSpacing: -0.3,
      ),
      displaySmall: chromeFont.displaySmall?.copyWith(
        fontSize: 18,
        height: 24 / 18,
        fontWeight: FontWeight.w600,
        color: onSurface,
      ),
      headlineMedium: chromeFont.headlineMedium?.copyWith(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w400,
        color: onSurface,
      ),
      // Sheet headings, app bar
      titleLarge: chromeFont.titleLarge?.copyWith(
        fontSize: 20,
        height: 26 / 20,
        fontWeight: FontWeight.w600,
        color: onSurface,
      ),
      titleMedium: chromeFont.titleMedium?.copyWith(
        fontSize: 17,
        height: 22 / 17,
        fontWeight: FontWeight.w600,
        color: onSurface,
      ),
      // Card title (semibold)
      titleSmall: chromeFont.titleSmall?.copyWith(
        fontSize: 15,
        height: 20 / 15,
        fontWeight: FontWeight.w600,
        color: onSurface,
      ),
      // Editor body
      bodyLarge: bodyFont.bodyLarge?.copyWith(
        fontSize: 17,
        height: 25 / 17,
        fontWeight: FontWeight.w400,
        color: onSurface,
      ),
      // Card preview, todos
      bodyMedium: bodyFont.bodyMedium?.copyWith(
        fontSize: 13,
        height: 19 / 13,
        fontWeight: FontWeight.w400,
        color: onSurfaceMuted,
      ),
      bodySmall: bodyFont.bodySmall?.copyWith(
        fontSize: 12,
        height: 16 / 12,
        fontWeight: FontWeight.w400,
        color: onSurfaceMuted,
      ),
      // Chips, metadata
      labelLarge: chromeFont.labelLarge?.copyWith(
        fontSize: 14,
        height: 18 / 14,
        fontWeight: FontWeight.w500,
        color: onSurface,
      ),
      labelMedium: chromeFont.labelMedium?.copyWith(
        fontSize: 13,
        height: 18 / 13,
        fontWeight: FontWeight.w500,
        color: onSurface,
      ),
      labelSmall: chromeFont.labelSmall?.copyWith(
        fontSize: 11,
        height: 14 / 11,
        fontWeight: FontWeight.w500,
        color: onSurfaceMuted,
        letterSpacing: 0.4,
      ),
    );
  }
}
