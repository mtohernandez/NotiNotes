import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../providers/search.dart';
import '../../providers/user_data.dart';
import '../../screens/settings_screen.dart';
import '../../screens/user_info_screen.dart';
import '../../theme/app_tokens.dart';

/// Large collapsing app bar with greeting, profile/settings actions, and a
/// persistent search field at the bottom edge.
class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = context.watch<UserData>();
    final user = userData.curentUserData;
    final greeting = userData.greeting();
    final scheme = Theme.of(context).colorScheme;

    return SliverAppBar(
      expandedHeight: 180,
      pinned: true,
      stretch: true,
      backgroundColor: scheme.surface,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          bottom: AppSpacing.lg + 48,
        ),
        title: LayoutBuilder(
          builder: (context, constraints) {
            return Text(
              user.name.isEmpty ? greeting : '$greeting, ${user.name}',
              style: Theme.of(context).textTheme.displayMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            );
          },
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: GestureDetector(
            onTap: () =>
                Navigator.of(context).pushNamed(UserInfoScreen.routeName),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: scheme.surfaceContainerHigh,
              backgroundImage: user.profilePicture != null
                  ? FileImage(File(user.profilePicture!.path))
                  : null,
              child: user.profilePicture == null
                  ? Icon(Icons.person_outline,
                      color: scheme.onSurfaceVariant, size: 20)
                  : null,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          tooltip: 'Settings',
          onPressed: () =>
              Navigator.of(context).pushNamed(SettingsScreen.routeName),
        ),
        const Gap(AppSpacing.sm),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            0,
            AppSpacing.lg,
            AppSpacing.sm,
          ),
          child: _SearchField(),
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final search = context.read<Search>();
    return TextField(
      onChanged: (value) {
        if (value.isEmpty) {
          search.deactivateSearch();
        } else {
          search.activateSearchByTitle();
        }
        search.setSearchQuery(value);
      },
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.search_rounded, size: 22),
        hintText: 'Search notes',
      ),
    );
  }
}
