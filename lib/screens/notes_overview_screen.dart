import 'package:flutter/material.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:noti_notes_app/widgets/note_item.dart';
import 'package:provider/provider.dart';

import '../widgets/appbar_item.dart';
import '../widgets/bottom_navigation_custom_item.dart';
import '../providers/notes.dart';
import '../providers/search.dart';

class NotesOverviewScreen extends StatelessWidget {
  static const routeName = '/notes-overview';
  const NotesOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<Notes>(context);
    final isSearching = Provider.of<Search>(context);
    final appBarSize = MediaQuery.of(context).size.height * 0.16;

    return GestureDetector(
      onTap: () {
        isSearching.deactivateSearch();
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBarItemTop(appBarSize),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isSearching.isSearching)
                Text(
                  'Searching "${isSearching.searchQuery}"',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              if (isSearching.isSearching)
                const SizedBox(
                  height: 10,
                ),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: MasonryGrid(
                        column: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        children: [
                          if (!isSearching.isSearching)
                            ...notes.notes
                                .map(
                                  (note) => NoteItem(
                                    note.tags,
                                    note.imageUrl,
                                    id: note.id,
                                    title: note.title,
                                    content: note.content,
                                    date: note.dateCreated,
                                  ),
                                )
                                .toList(),
                          if (isSearching.isSearching)
                            ...notes
                                .filterByTitle(isSearching.searchQuery)
                                .map(
                                  (note) => NoteItem(
                                    note.tags,
                                    note.imageUrl,
                                    id: note.id,
                                    title: note.title,
                                    content: note.content,
                                    date: note.dateCreated,
                                  ),
                                )
                                .toList(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationCustomItem(),
      ),
    );
  }
}
