import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../providers/notes.dart';
import '../providers/search.dart';
import '../theme/app_tokens.dart';
import '../widgets/home/empty_state.dart';
import '../widgets/home/filter_chips_row.dart';
import '../widgets/home/home_app_bar.dart';
import '../widgets/home/note_card.dart';
import '../widgets/home/section_header.dart';
import '../widgets/sheets/long_press_menu_sheet.dart';
import 'note_editor_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';
  const HomeScreen({super.key});

  /// Apply title search and filter chip to the visible note list.
  List<Note> _applyFilters(List<Note> source, Search search) {
    Iterable<Note> result = source;
    if (search.searchQuery.isNotEmpty) {
      final q = search.searchQuery.toLowerCase();
      result = result.where((n) => n.title.toLowerCase().contains(q));
    }
    switch (search.filter) {
      case NoteFilter.all:
        break;
      case NoteFilter.reminders:
        result = result.where((n) => n.reminder != null);
        break;
      case NoteFilter.checklists:
        result = result.where((n) => n.blocks.any((b) => b['type'] == 'checklist'));
        break;
      case NoteFilter.images:
        result = result.where((n) =>
            n.blocks.any((b) => b['type'] == 'image') || n.imageFile != null);
        break;
    }
    return result.toList();
  }

  @override
  Widget build(BuildContext context) {
    final notes = context.watch<Notes>();
    final search = context.watch<Search>();
    final scheme = Theme.of(context).colorScheme;

    final pinned = _applyFilters(notes.pinnedNotes, search);
    final unpinned = _applyFilters(notes.unpinnedNotes, search);
    final isEmpty = pinned.isEmpty && unpinned.isEmpty;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const HomeAppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),
          const SliverToBoxAdapter(child: FilterChipsRow()),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),
          if (isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: EmptyState(),
            )
          else ...[
            if (pinned.isNotEmpty) ...[
              const SliverToBoxAdapter(child: SectionHeader('Pinned')),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                ),
                sliver: SliverMasonryGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: AppSpacing.md,
                  crossAxisSpacing: AppSpacing.md,
                  childCount: pinned.length,
                  itemBuilder: (context, i) =>
                      _buildOpenContainerCard(context, pinned[i]),
                ),
              ),
            ],
            if (unpinned.isNotEmpty)
              SliverToBoxAdapter(
                child: SectionHeader(
                  pinned.isNotEmpty ? 'Notes' : 'All notes',
                ),
              ),
            if (unpinned.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                ),
                sliver: SliverMasonryGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: AppSpacing.md,
                  crossAxisSpacing: AppSpacing.md,
                  childCount: unpinned.length,
                  itemBuilder: (context, i) =>
                      _buildOpenContainerCard(context, unpinned[i]),
                ),
              ),
          ],
          const SliverToBoxAdapter(child: SizedBox(height: 96)),
        ],
      ),
      floatingActionButton: OpenContainer(
        closedElevation: 6,
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.lg)),
        ),
        closedColor: scheme.primary,
        openColor: scheme.surface,
        transitionDuration: AppDurations.md,
        transitionType: ContainerTransitionType.fadeThrough,
        closedBuilder: (context, openContainer) => SizedBox(
          width: 56,
          height: 56,
          child: Center(
            child: Icon(Icons.add, color: scheme.onPrimary, size: 28),
          ),
        ),
        openBuilder: (context, _) => const NoteEditorScreen(),
      ),
    );
  }

  Widget _buildOpenContainerCard(BuildContext context, Note note) {
    return OpenContainer(
      closedElevation: 0,
      openElevation: 0,
      closedColor: note.hasGradient
          ? note.colorBackground
          : note.colorBackground,
      openColor: Theme.of(context).colorScheme.surface,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      transitionDuration: AppDurations.md,
      transitionType: ContainerTransitionType.fadeThrough,
      closedBuilder: (context, openContainer) => NoteCard(
        note: note,
        onTap: openContainer,
        onLongPress: () => showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          useSafeArea: true,
          builder: (_) => LongPressMenuSheet(noteId: note.id),
        ),
      ),
      openBuilder: (context, _) => NoteEditorScreen(noteId: note.id),
    );
  }
}
