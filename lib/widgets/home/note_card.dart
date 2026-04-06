import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../models/note.dart';
import '../../theme/app_tokens.dart';
import '../../theme/notes_color_palette.dart';
import '../editor/editor_block.dart';

/// Visual card for a note in the masonry grid. Designed to read well at small
/// sizes with auto-contrast text on per-note color backgrounds.
class NoteCard extends StatefulWidget {
  final Note note;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const NoteCard({
    super.key,
    required this.note,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final scheme = Theme.of(context).colorScheme;
    final note = widget.note;
    final swatch = NotesColorPalette.swatchFor(note.colorBackground);
    final textColor = swatch?.autoTextColor(brightness) ??
        (note.colorBackground.computeLuminance() > 0.5
            ? const Color(0xFF1A1A1A)
            : const Color(0xFFF5F5F5));

    final blocks = note.blocks.isNotEmpty
        ? note.blocks.map(EditorBlock.fromMap).toList()
        : <EditorBlock>[];

    final textBlocks = blocks.whereType<TextBlock>().toList();
    final checklistBlocks = blocks.whereType<ChecklistBlock>().toList();
    final imageBlocks = blocks.whereType<ImageBlock>().toList();
    final hasContent = textBlocks.any((b) => b.text.isNotEmpty) ||
        checklistBlocks.isNotEmpty ||
        imageBlocks.isNotEmpty ||
        note.title.isNotEmpty;

    final preview = textBlocks
        .map((b) => b.text)
        .where((t) => t.isNotEmpty)
        .join('\n');

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      onTap: widget.onTap,
      onLongPress: () {
        HapticFeedback.selectionClick();
        widget.onLongPress();
      },
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: AppDurations.xs,
        curve: AppCurves.standard,
        child: Container(
          decoration: BoxDecoration(
            color: note.hasGradient ? null : note.colorBackground,
            gradient: note.hasGradient ? note.gradient : null,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            image: note.patternImage != null
                ? DecorationImage(
                    image: AssetImage(note.patternImage!),
                    fit: BoxFit.cover,
                    opacity: 0.4,
                    colorFilter: ColorFilter.mode(
                      note.colorBackground,
                      BlendMode.softLight,
                    ),
                  )
                : null,
            border: brightness == Brightness.dark
                ? Border.all(
                    color: scheme.outlineVariant.withValues(alpha: 0.3),
                    width: 1,
                  )
                : null,
          ),
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (note.isPinned)
                Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.push_pin,
                    size: 14,
                    color: textColor.withValues(alpha: 0.7),
                  ),
                ),
              if (imageBlocks.isNotEmpty) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  child: Image.file(
                    File(imageBlocks.first.path),
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 60,
                      color: textColor.withValues(alpha: 0.1),
                    ),
                  ),
                ),
                const Gap(AppSpacing.sm),
              ],
              if (note.title.isNotEmpty)
                Text(
                  note.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: textColor,
                      ),
                ),
              if (preview.isNotEmpty) ...[
                if (note.title.isNotEmpty) const Gap(AppSpacing.xs),
                Text(
                  preview,
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: textColor.withValues(alpha: 0.85),
                      ),
                ),
              ],
              if (checklistBlocks.isNotEmpty) ...[
                const Gap(AppSpacing.xs),
                ...checklistBlocks.take(4).map(
                      (b) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              b.checked
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                              size: 14,
                              color: textColor.withValues(alpha: 0.85),
                            ),
                            const Gap(AppSpacing.xs),
                            Expanded(
                              child: Text(
                                b.text.isEmpty ? 'Untitled task' : b.text,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: textColor.withValues(
                                          alpha: b.checked ? 0.5 : 0.85),
                                      decoration: b.checked
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                if (checklistBlocks.length > 4)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      '+${checklistBlocks.length - 4} more',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: textColor.withValues(alpha: 0.6),
                          ),
                    ),
                  ),
              ],
              if (note.tags.isNotEmpty) ...[
                const Gap(AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  children: note.tags.take(3).map((t) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: textColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(AppRadius.full),
                      ),
                      child: Text(
                        '#$t',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: textColor,
                            ),
                      ),
                    );
                  }).toList(),
                ),
              ],
              if (note.reminder != null) ...[
                const Gap(AppSpacing.sm),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.notifications_active_outlined,
                      size: 12,
                      color: textColor.withValues(alpha: 0.7),
                    ),
                    const Gap(AppSpacing.xs),
                    Text(
                      DateFormat('MMM d · HH:mm').format(note.reminder!),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: textColor.withValues(alpha: 0.7),
                          ),
                    ),
                  ],
                ),
              ],
              if (!hasContent)
                Text(
                  'Empty note',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: textColor.withValues(alpha: 0.5),
                        fontStyle: FontStyle.italic,
                      ),
                ),
              const Gap(AppSpacing.sm),
              Text(
                DateFormat('MMM d').format(note.dateCreated),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: textColor.withValues(alpha: 0.55),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
