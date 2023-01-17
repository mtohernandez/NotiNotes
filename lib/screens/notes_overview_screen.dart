import 'package:flutter/material.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:noti_notes_app/widgets/items/note_item.dart';
import 'package:provider/provider.dart';

import '../widgets/items/icon_button_x_item.dart';
import '../widgets/navigation/appbar_item.dart';
import '../widgets/navigation/bottom_navigation_custom_item.dart';
import '../providers/notes.dart';
import '../providers/search.dart';

class NotesOverviewScreen extends StatelessWidget {
  static const routeName = '/notes-overview';
  const NotesOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<Notes>(context);
    final isSearching = Provider.of<Search>(context);
    final appBarSize = MediaQuery.of(context).size.height * 0.15;

    return GestureDetector(
      onTap: () {
        // isSearching.deactivateSearch();
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBarItemTop(appBarSize),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (notes.editMode &&
                  isSearching.isSearching == SearchType.notSearching)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'On edit mode',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            notes.removeSelectedNotes(notes.notesToDelete);
                            notes.deactivateEditMode();
                          },
                          child: Text(
                            'Delete Selected',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Theme.of(context).errorColor),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            notes.deactivateEditMode();
                          },
                          child: Text(
                            'Cancel',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color!
                                          .withOpacity(.5),
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              if (isSearching.isSearching == SearchType.searchingByTitle)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Searching "${isSearching.searchQuery}"',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    IconButtonXItem(isSearching.deactivateSearch),
                  ],
                ),
              if (isSearching.isSearching == SearchType.searchingByTitle)
                SizedBox(
                  height: Theme.of(context).textTheme.bodyText1!.fontSize,
                ),
              Expanded(
                child: isSearching.isSearching == SearchType.notSearching &&
                        notes.notes.isEmpty
                    ? Center(
                        child: Text(
                          'No notes yet. Press + to create one!',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color!
                                        .withOpacity(0.5),
                                  ),
                        ),
                      )
                    : notes.filterByTitle(isSearching.searchQuery).isEmpty &&
                            isSearching.isSearching ==
                                SearchType.searchingByTitle
                        ? Center(
                            child: Text(
                              'No notes found.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color!
                                        .withOpacity(0.5),
                                  ),
                            ),
                          )
                        : CustomScrollView(
                            slivers: [
                              SliverToBoxAdapter(
                                child: MasonryGrid(
                                  column: 2,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                  children: [
                                    if (isSearching.isSearching ==
                                        SearchType.notSearching)
                                      ...notes.notes
                                          .map(
                                            (note) => NoteItem(
                                              note.tags,
                                              note.imageFile,
                                              note.patternImage,
                                              id: note.id,
                                              title: note.title,
                                              content: note.content,
                                              date: note.dateCreated,
                                              colorBackground:
                                                  note.colorBackground,
                                            ),
                                          )
                                          .toList(),
                                    if (isSearching.isSearching ==
                                        SearchType.searchingByTitle)
                                      ...notes
                                          .filterByTitle(
                                              isSearching.searchQuery)
                                          .map(
                                            (note) => NoteItem(
                                              note.tags,
                                              note.imageFile,
                                               note.patternImage,
                                              id: note.id,
                                              title: note.title,
                                              content: note.content,
                                              date: note.dateCreated,
                                              colorBackground:
                                                  note.colorBackground,
                                            ),
                                          )
                                          .toList(),
                                    if (isSearching.isSearching ==
                                        SearchType.searchingByTag)
                                      ...notes
                                          .filterByTag(isSearching.searchTags)
                                          .map(
                                            (note) => NoteItem(
                                              note.tags,
                                              note.imageFile,
                                              note.patternImage,
                                              id: note.id,
                                              title: note.title,
                                              content: note.content,
                                              date: note.dateCreated,
                                              colorBackground:
                                                  note.colorBackground,
                                            ),
                                          )
                                          .toList(),
                                  ],
                                ),
                              ),
                            ],
                          ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavigationCustomItem(),
      ),
    );
  }
}
