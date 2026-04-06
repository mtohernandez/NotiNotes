import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../providers/notes.dart';
import '../../theme/app_tokens.dart';
import 'sheet_scaffold.dart';

/// Bottom sheet shown on long-press of a note card. Replaces the old
/// screen-wide edit mode with a per-card menu (Pin / Duplicate / Delete).
class LongPressMenuSheet extends StatelessWidget {
  final String noteId;
  const LongPressMenuSheet({super.key, required this.noteId});

  @override
  Widget build(BuildContext context) {
    final note = context.read<Notes>().findById(noteId);
    return SheetScaffold(
      title: note.title.isEmpty ? 'Untitled note' : note.title,
      maxHeightFactor: 0.5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _MenuTile(
            icon: note.isPinned
                ? Icons.push_pin
                : Icons.push_pin_outlined,
            label: note.isPinned ? 'Unpin' : 'Pin',
            onTap: () {
              HapticFeedback.selectionClick();
              context.read<Notes>().togglePin(noteId);
              Navigator.of(context).pop();
            },
          ),
          const Gap(AppSpacing.xs),
          _MenuTile(
            icon: Icons.delete_outline,
            label: 'Delete',
            destructive: true,
            onTap: () {
              HapticFeedback.selectionClick();
              context.read<Notes>().deleteNote(noteId);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool destructive;

  const _MenuTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.destructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = destructive ? Colors.redAccent : scheme.onSurface;
    return Material(
      color: scheme.surfaceContainerHigh,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.md),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 22),
              const Gap(AppSpacing.md),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
