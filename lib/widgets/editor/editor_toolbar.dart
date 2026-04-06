import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import '../../theme/app_tokens.dart';

/// Docked toolbar above the keyboard. Each button is a [_ToolButton] with a
/// gentle press scale animation. The state of each affordance is owned by the
/// parent editor screen via callbacks.
class EditorToolbar extends StatelessWidget {
  final bool currentBlockIsChecklist;
  final VoidCallback onToggleChecklist;
  final VoidCallback onAddImage;
  final VoidCallback onOpenStyleSheet;
  final VoidCallback onOpenReminderSheet;
  final VoidCallback onOpenTagSheet;
  final VoidCallback onDoneEditing;

  const EditorToolbar({
    super.key,
    required this.currentBlockIsChecklist,
    required this.onToggleChecklist,
    required this.onAddImage,
    required this.onOpenStyleSheet,
    required this.onOpenReminderSheet,
    required this.onOpenTagSheet,
    required this.onDoneEditing,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        border: Border(
          top: BorderSide(
            color: scheme.outlineVariant.withValues(alpha: 0.4),
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            _ToolButton(
              icon: currentBlockIsChecklist
                  ? Icons.check_box_rounded
                  : Icons.check_box_outline_blank_rounded,
              tooltip: 'Toggle checklist',
              selected: currentBlockIsChecklist,
              onTap: () {
                HapticFeedback.selectionClick();
                onToggleChecklist();
              },
            ),
            const Gap(AppSpacing.xs),
            _ToolButton(
              icon: Icons.image_outlined,
              tooltip: 'Add image',
              onTap: onAddImage,
            ),
            const Gap(AppSpacing.xs),
            _ToolButton(
              icon: Icons.palette_outlined,
              tooltip: 'Style',
              onTap: onOpenStyleSheet,
            ),
            const Gap(AppSpacing.xs),
            _ToolButton(
              icon: Icons.notifications_outlined,
              tooltip: 'Reminder',
              onTap: onOpenReminderSheet,
            ),
            const Gap(AppSpacing.xs),
            _ToolButton(
              icon: Icons.tag_rounded,
              tooltip: 'Tags',
              onTap: onOpenTagSheet,
            ),
            const Spacer(),
            TextButton(
              onPressed: onDoneEditing,
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ToolButton extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final bool selected;

  const _ToolButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.selected = false,
  });

  @override
  State<_ToolButton> createState() => _ToolButtonState();
}

class _ToolButtonState extends State<_ToolButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Tooltip(
      message: widget.tooltip,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapCancel: () => setState(() => _pressed = false),
        onTapUp: (_) => setState(() => _pressed = false),
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _pressed ? 0.92 : 1.0,
          duration: AppDurations.xs,
          curve: AppCurves.standard,
          child: AnimatedContainer(
            duration: AppDurations.xs,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: widget.selected
                  ? scheme.primary.withValues(alpha: 0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Icon(
              widget.icon,
              size: 22,
              color: widget.selected
                  ? scheme.primary
                  : scheme.onSurface.withValues(alpha: 0.85),
            ),
          ),
        ),
      ),
    );
  }
}
