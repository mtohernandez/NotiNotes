import 'dart:io';

import 'package:flutter/material.dart';

import '../../theme/app_tokens.dart';

/// A full-width image block with a delete button overlay.
class ImageBlockWidget extends StatelessWidget {
  final String path;
  final VoidCallback onDelete;

  const ImageBlockWidget({
    super.key,
    required this.path,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Stack(
          children: [
            Image.file(
              File(path),
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 120,
                color: scheme.surfaceContainerHigh,
                alignment: Alignment.center,
                child: Icon(Icons.broken_image, color: scheme.onSurfaceVariant),
              ),
            ),
            Positioned(
              top: AppSpacing.sm,
              right: AppSpacing.sm,
              child: Material(
                color: Colors.black.withValues(alpha: 0.5),
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: onDelete,
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.close, color: Colors.white, size: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
