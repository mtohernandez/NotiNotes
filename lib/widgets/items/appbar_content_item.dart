import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:noti_notes_app/widgets/items/tag_item.dart';
import 'package:noti_notes_app/providers/notes.dart';

class AppBarContentItem extends StatelessWidget {
  const AppBarContentItem({super.key});

  Set<String> importTags(Notes notes) {
    // Using fold to return a set of all tags from all notes in the notes provider
    return notes.notes.fold(
      <String>{},
      (previousValue, note) => previousValue..addAll(note.tags),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<Notes>(context);

    Set<String> allTags = importTags(notes);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        if (allTags.isNotEmpty)
          SizedBox(
            height: Theme.of(context).textTheme.bodyText1!.fontSize! * 2.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => TagItem(
                null,
                0,
                tag: allTags.elementAt(index),
                isForSearch: true,
                isForCreation: false,
                backgroundColor:
                    Theme.of(context).backgroundColor, // Does not matter
              ),
              itemCount: allTags.length,
            ),
          )
      ],
    );
  }
}
