import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_tag_editor/tag_editor.dart';
import 'package:provider/provider.dart';

import '../../providers/notes.dart';
import '../../theme/app_tokens.dart';
import 'sheet_scaffold.dart';

/// Tag editor in a bottom sheet. Suggested tags are surfaced from the most-
/// used set across all notes; tapping one adds it instantly. Free input uses
/// comma as the delimiter.
class TagSheet extends StatefulWidget {
  final String noteId;
  const TagSheet({super.key, required this.noteId});

  @override
  State<TagSheet> createState() => _TagSheetState();
}

class _TagSheetState extends State<TagSheet> {
  late List<String> _values;

  @override
  void initState() {
    super.initState();
    _values = context
        .read<Notes>()
        .findById(widget.noteId)
        .tags
        .toList(growable: true);
  }

  void _addTag(String tag) {
    final cleaned = tag.trim();
    if (cleaned.isEmpty || _values.contains(cleaned)) return;
    setState(() => _values.add(cleaned));
    context.read<Notes>().addTagToNote(cleaned, widget.noteId);
  }

  void _removeTag(int index) {
    setState(() => _values.removeAt(index));
    context.read<Notes>().removeTagsFromNote(index, widget.noteId);
  }

  @override
  Widget build(BuildContext context) {
    final notes = context.read<Notes>();
    final suggested =
        notes.getMostUsedTags().where((t) => !_values.contains(t)).toList();
    final scheme = Theme.of(context).colorScheme;

    return SheetScaffold(
      title: 'Tags',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (suggested.isNotEmpty) ...[
              Text(
                'SUGGESTED',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      letterSpacing: 1.2,
                      color: scheme.onSurfaceVariant,
                    ),
              ),
              const Gap(AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: suggested
                    .map(
                      (tag) => ActionChip(
                        label: Text('#$tag'),
                        onPressed: () => _addTag(tag),
                      ),
                    )
                    .toList(),
              ),
              const Gap(AppSpacing.lg),
            ],
            Text(
              'YOUR TAGS',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    letterSpacing: 1.2,
                    color: scheme.onSurfaceVariant,
                  ),
            ),
            const Gap(AppSpacing.sm),
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              child: TagEditor(
                length: _values.length,
                delimiters: const [','],
                hasAddButton: false,
                resetTextOnSubmitted: true,
                inputDecoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add a tag, comma to confirm',
                ),
                textStyle: Theme.of(context).textTheme.bodyLarge,
                onSubmitted: _addTag,
                onTagChanged: _addTag,
                tagBuilder: (context, index) => Container(
                  margin: const EdgeInsets.only(right: 6, bottom: 4),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: scheme.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppRadius.full),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '#${_values[index]}',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: scheme.primary,
                            ),
                      ),
                      const Gap(4),
                      GestureDetector(
                        onTap: () => _removeTag(index),
                        child: Icon(Icons.close,
                            size: 14, color: scheme.primary),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Gap(AppSpacing.md),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Done'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
