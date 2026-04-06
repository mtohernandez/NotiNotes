import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../helpers/photo_picker.dart';
import '../providers/notes.dart';
import '../providers/user_data.dart';
import '../theme/app_tokens.dart';

class UserInfoScreen extends StatelessWidget {
  static const routeName = '/user-info';
  const UserInfoScreen({super.key});

  Future<void> _pickProfileImage(BuildContext context) async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Choose from gallery'),
              onTap: () => Navigator.of(context).pop(ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Take a photo'),
              onTap: () => Navigator.of(context).pop(ImageSource.camera),
            ),
          ],
        ),
      ),
    );
    if (source == null) return;
    final file = await PhotoPicker.pickImage(source, 80);
    if (file != null && context.mounted) {
      context.read<UserData>().updateProfilePicture(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserData>().curentUserData;
    final notes = context.watch<Notes>();
    final scheme = Theme.of(context).colorScheme;
    final mostUsed = notes.getMostUsedTags();

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => _pickProfileImage(context),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: scheme.surfaceContainerHigh,
                    image: user.profilePicture != null
                        ? DecorationImage(
                            image: FileImage(File(user.profilePicture!.path)),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: user.profilePicture == null
                      ? Icon(Icons.person_outline,
                          size: 40, color: scheme.onSurfaceVariant)
                      : null,
                ),
              ),
              const Gap(AppSpacing.lg),
              Expanded(
                child: TextFormField(
                  initialValue: user.name,
                  maxLength: 30,
                  style: Theme.of(context).textTheme.titleLarge,
                  decoration: const InputDecoration(
                    counterText: '',
                    hintText: 'Your name',
                  ),
                  onChanged: (name) =>
                      context.read<UserData>().updateName(name),
                ),
              ),
            ],
          ),
          const Gap(AppSpacing.xl),
          Text(
            '${notes.notesCount} notes on this device',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Gap(AppSpacing.xl),
          Text(
            'TAGS YOU USE THE MOST',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  letterSpacing: 1.2,
                  color: scheme.onSurfaceVariant,
                ),
          ),
          const Gap(AppSpacing.sm),
          if (mostUsed.isEmpty)
            Text(
              'No tags yet.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
            )
          else
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: mostUsed
                  .map(
                    (t) => Chip(
                      label: Text('#$t'),
                      backgroundColor: scheme.surfaceContainerHigh,
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}
