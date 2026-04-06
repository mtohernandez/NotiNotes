import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../helpers/color_picker.dart' as legacy;
import '../../providers/notes.dart';
import '../../theme/app_tokens.dart';
import '../../theme/notes_color_palette.dart';
import 'sheet_scaffold.dart';

/// Unified personalization sheet. Four sections — color, gradient, pattern,
/// text color — visible at once with vertical scrolling. Changes apply
/// immediately to the open editor (live preview behind the sheet).
class NoteStyleSheet extends StatefulWidget {
  final String noteId;

  const NoteStyleSheet({super.key, required this.noteId});

  @override
  State<NoteStyleSheet> createState() => _NoteStyleSheetState();
}

class _NoteStyleSheetState extends State<NoteStyleSheet> {
  bool _showTextColor = false;

  @override
  Widget build(BuildContext context) {
    final notes = context.watch<Notes>();
    final note = notes.findById(widget.noteId);
    final brightness = Theme.of(context).brightness;
    final scheme = Theme.of(context).colorScheme;

    return SheetScaffold(
      title: 'Style',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionLabel('Color'),
            const Gap(AppSpacing.sm),
            SizedBox(
              height: 48,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: NotesColorPalette.swatches.length,
                separatorBuilder: (_, __) => const Gap(AppSpacing.md),
                itemBuilder: (_, i) {
                  final swatch = NotesColorPalette.swatches[i];
                  final color = swatch.background(brightness);
                  final selected = !note.hasGradient &&
                      note.patternImage == null &&
                      note.colorBackground.toARGB32() == color.toARGB32();
                  return _SwatchCircle(
                    color: color,
                    selected: selected,
                    onTap: () {
                      HapticFeedback.selectionClick();
                      final notesP = context.read<Notes>();
                      notesP.changeCurrentColor(widget.noteId, color);
                      if (note.hasGradient) notesP.switchGradient(widget.noteId);
                      if (note.patternImage != null) {
                        notesP.removeCurrentPattern(widget.noteId);
                      }
                    },
                  );
                },
              ),
            ),
            const Gap(AppSpacing.lg),
            _SectionLabel('Gradient'),
            const Gap(AppSpacing.sm),
            SizedBox(
              height: 72,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: NotesGradientPalette.gradients.length,
                separatorBuilder: (_, __) => const Gap(AppSpacing.md),
                itemBuilder: (_, i) {
                  final gradient = NotesGradientPalette.gradients[i];
                  final selected = note.hasGradient &&
                      note.gradient != null &&
                      _gradientsEqual(note.gradient!, gradient);
                  return _GradientThumb(
                    gradient: gradient,
                    selected: selected,
                    onTap: () {
                      final notesP = context.read<Notes>();
                      notesP.changeCurrentGradient(widget.noteId, gradient);
                      if (!note.hasGradient) {
                        notesP.switchGradient(widget.noteId);
                      }
                      if (note.patternImage != null) {
                        notesP.removeCurrentPattern(widget.noteId);
                      }
                    },
                  );
                },
              ),
            ),
            const Gap(AppSpacing.lg),
            _SectionLabel('Pattern'),
            const Gap(AppSpacing.sm),
            SizedBox(
              height: 72,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: legacy.ColorPicker.patterns.length + 1,
                separatorBuilder: (_, __) => const Gap(AppSpacing.md),
                itemBuilder: (_, i) {
                  if (i == 0) {
                    final selected = note.patternImage == null;
                    return _PatternThumb(
                      asset: null,
                      selected: selected,
                      onTap: () => context
                          .read<Notes>()
                          .removeCurrentPattern(widget.noteId),
                    );
                  }
                  final asset = legacy.ColorPicker.patterns[i - 1];
                  final selected = note.patternImage == asset;
                  return _PatternThumb(
                    asset: asset,
                    selected: selected,
                    onTap: () {
                      final notesP = context.read<Notes>();
                      notesP.changeCurrentPattern(widget.noteId, asset);
                      if (note.hasGradient) notesP.switchGradient(widget.noteId);
                    },
                  );
                },
              ),
            ),
            const Gap(AppSpacing.lg),
            InkWell(
              onTap: () => setState(() => _showTextColor = !_showTextColor),
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: Row(
                  children: [
                    Expanded(child: _SectionLabel('Text color')),
                    Icon(
                      _showTextColor
                          ? Icons.expand_less_rounded
                          : Icons.expand_more_rounded,
                      color: scheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
            ),
            AnimatedSize(
              duration: AppDurations.sm,
              curve: AppCurves.standard,
              alignment: Alignment.topCenter,
              child: _showTextColor
                  ? Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.sm),
                      child: SizedBox(
                        height: 48,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: NotesTextColorPalette.colors.length,
                          separatorBuilder: (_, __) => const Gap(AppSpacing.md),
                          itemBuilder: (_, i) {
                            final color = NotesTextColorPalette.colors[i];
                            final selected =
                                note.fontColor.toARGB32() == color.toARGB32();
                            return _SwatchCircle(
                              color: color,
                              selected: selected,
                              onTap: () => context
                                  .read<Notes>()
                                  .changeCurrentFontColor(widget.noteId, color),
                            );
                          },
                        ),
                      ),
                    )
                  : const SizedBox(width: double.infinity),
            ),
          ],
        ),
      ),
    );
  }
}

bool _gradientsEqual(LinearGradient a, LinearGradient b) {
  if (a.colors.length != b.colors.length) return false;
  for (int i = 0; i < a.colors.length; i++) {
    if (a.colors[i].toARGB32() != b.colors[i].toARGB32()) return false;
  }
  return true;
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);
  @override
  Widget build(BuildContext context) => Text(
        text.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              letterSpacing: 1.2,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
      );
}

class _SwatchCircle extends StatelessWidget {
  final Color color;
  final bool selected;
  final VoidCallback onTap;
  const _SwatchCircle({
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppDurations.xs,
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: selected
                ? scheme.primary
                : scheme.outlineVariant.withValues(alpha: 0.5),
            width: selected ? 2.5 : 1,
          ),
        ),
        child: selected
            ? Icon(
                Icons.check,
                size: 20,
                color: color.computeLuminance() > 0.5
                    ? Colors.black
                    : Colors.white,
              )
            : null,
      ),
    );
  }
}

class _GradientThumb extends StatelessWidget {
  final LinearGradient gradient;
  final bool selected;
  final VoidCallback onTap;
  const _GradientThumb({
    required this.gradient,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppDurations.xs,
        width: 56,
        height: 72,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: selected ? scheme.primary : Colors.transparent,
            width: selected ? 2.5 : 0,
          ),
        ),
        child: selected
            ? const Center(
                child: Icon(Icons.check, color: Colors.white, size: 22),
              )
            : null,
      ),
    );
  }
}

class _PatternThumb extends StatelessWidget {
  final String? asset;
  final bool selected;
  final VoidCallback onTap;
  const _PatternThumb({
    required this.asset,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppDurations.xs,
        width: 56,
        height: 72,
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(AppRadius.md),
          image: asset != null
              ? DecorationImage(image: AssetImage(asset!), fit: BoxFit.cover)
              : null,
          border: Border.all(
            color: selected ? scheme.primary : Colors.transparent,
            width: selected ? 2.5 : 0,
          ),
        ),
        child: asset == null
            ? Center(
                child: Icon(
                  Icons.block,
                  color: scheme.onSurfaceVariant,
                ),
              )
            : null,
      ),
    );
  }
}
