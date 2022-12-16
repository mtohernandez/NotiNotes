import 'package:flutter/material.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:noti_notes_app/widgets/note_item.dart';
import 'package:provider/provider.dart';

import '../widgets/appbar_item.dart';
import '../widgets/bottom_navigation_custom_item.dart';
import '../providers/notes.dart';

class NotesOverviewScreen extends StatelessWidget {
  static const routeName = '/notes-overview';
  const NotesOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<Notes>(context).notes;
    final appBarSize = MediaQuery.of(context).size.height * 0.16;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBarItemTop(appBarSize),
        backgroundColor: Theme.of(context).backgroundColor,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: MasonryGrid(
                  column: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  children: [
                    ...notes
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
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationCustomItem(),
      ),
    );
  }
}
