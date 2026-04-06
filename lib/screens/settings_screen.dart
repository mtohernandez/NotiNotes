import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../theme/app_tokens.dart';
import '../theme/app_typography.dart';
import '../theme/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        children: const [
          _SectionLabel('Appearance'),
          Gap(AppSpacing.sm),
          _ThemeModePicker(),
          Gap(AppSpacing.xl),
          _SectionLabel('Writing font'),
          Gap(AppSpacing.sm),
          _WritingFontPicker(),
          Gap(AppSpacing.xl),
          _SectionLabel('About'),
          Gap(AppSpacing.sm),
          _AboutTile(),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
        child: Text(
          text.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                letterSpacing: 1.2,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      );
}

class _ThemeModePicker extends StatelessWidget {
  const _ThemeModePicker();

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();
    return SegmentedButton<ThemeMode>(
      segments: const [
        ButtonSegment(
          value: ThemeMode.system,
          label: Text('System'),
          icon: Icon(Icons.brightness_auto_outlined),
        ),
        ButtonSegment(
          value: ThemeMode.light,
          label: Text('Light'),
          icon: Icon(Icons.light_mode_outlined),
        ),
        ButtonSegment(
          value: ThemeMode.dark,
          label: Text('Dark'),
          icon: Icon(Icons.dark_mode_outlined),
        ),
      ],
      selected: {theme.themeMode},
      onSelectionChanged: (set) =>
          context.read<ThemeProvider>().setThemeMode(set.first),
    );
  }
}

class _WritingFontPicker extends StatelessWidget {
  const _WritingFontPicker();

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: WritingFont.values.map((font) {
        final selected = theme.writingFont == font;
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: Material(
            color: selected
                ? scheme.primary.withValues(alpha: 0.12)
                : scheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            child: InkWell(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              onTap: () => context.read<ThemeProvider>().setWritingFont(font),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            font.displayName,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Gap(AppSpacing.xs),
                          Text(
                            'The quick brown fox jumps over the lazy dog',
                            style: GoogleFonts.getFont(
                              font.googleFontName,
                              fontSize: 16,
                              color: scheme.onSurface.withValues(alpha: 0.85),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (selected)
                      Icon(Icons.check_circle, color: scheme.primary),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _AboutTile extends StatelessWidget {
  const _AboutTile();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surfaceContainerHigh,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('NotiNotes 2.0', style: Theme.of(context).textTheme.titleMedium),
            const Gap(AppSpacing.xs),
            Text(
              'A customizable, offline notes app built with Flutter.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
