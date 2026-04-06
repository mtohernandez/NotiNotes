import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Slim editor app bar with back, pin, and overflow menu.
class NoteAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isPinned;
  final VoidCallback onTogglePin;
  final VoidCallback onDelete;
  final VoidCallback? onShare;
  final Color? foregroundColor;
  final Color? backgroundColor;

  const NoteAppBar({
    super.key,
    required this.isPinned,
    required this.onTogglePin,
    required this.onDelete,
    this.onShare,
    this.foregroundColor,
    this.backgroundColor,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fg = foregroundColor ?? scheme.onSurface;
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      surfaceTintColor: Colors.transparent,
      foregroundColor: fg,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_rounded, color: fg),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
      actions: [
        IconButton(
          tooltip: isPinned ? 'Unpin' : 'Pin',
          icon: Icon(
            isPinned ? Icons.push_pin : Icons.push_pin_outlined,
            color: fg,
          ),
          onPressed: () {
            HapticFeedback.selectionClick();
            onTogglePin();
          },
        ),
        PopupMenuButton<String>(
          icon: Icon(Icons.more_horiz_rounded, color: fg),
          color: scheme.surfaceContainerHigh,
          onSelected: (value) {
            switch (value) {
              case 'delete':
                onDelete();
                break;
              case 'share':
                onShare?.call();
                break;
            }
          },
          itemBuilder: (context) => [
            if (onShare != null)
              const PopupMenuItem(
                value: 'share',
                child: ListTile(
                  leading: Icon(Icons.share_outlined),
                  title: Text('Share'),
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                ),
              ),
            const PopupMenuItem(
              value: 'delete',
              child: ListTile(
                leading: Icon(Icons.delete_outline, color: Colors.redAccent),
                title: Text('Delete', style: TextStyle(color: Colors.redAccent)),
                contentPadding: EdgeInsets.zero,
                dense: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
