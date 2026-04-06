import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../providers/search.dart';
import '../../theme/app_tokens.dart';

/// Horizontal row of filter chips below the search bar. Selection is single.
class FilterChipsRow extends StatelessWidget {
  const FilterChipsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final search = context.watch<Search>();
    final entries = const [
      (NoteFilter.all, 'All', Icons.notes_outlined),
      (NoteFilter.reminders, 'Reminders', Icons.notifications_outlined),
      (NoteFilter.checklists, 'Checklists', Icons.checklist_rounded),
      (NoteFilter.images, 'Images', Icons.image_outlined),
    ];
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        itemCount: entries.length,
        separatorBuilder: (_, __) => const Gap(AppSpacing.sm),
        itemBuilder: (_, i) {
          final (filter, label, icon) = entries[i];
          final selected = search.filter == filter;
          return FilterChip(
            avatar: Icon(icon, size: 16),
            label: Text(label),
            selected: selected,
            onSelected: (_) => context.read<Search>().setFilter(filter),
            showCheckmark: false,
          );
        },
      ),
    );
  }
}
