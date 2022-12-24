import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/note.dart';
import '../../providers/notes.dart';

class AppBarNoteTitle extends StatelessWidget implements PreferredSizeWidget {
  const AppBarNoteTitle({
    required this.loadedNote,
    super.key,
  });

  final Note loadedNote;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).backgroundColor,
      elevation: 0,
      title: TextFormField(
        autofocus: loadedNote.title.isEmpty ? true : false,
        initialValue: loadedNote.title,
        style: Theme.of(context).textTheme.headline1,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Title',
            hintStyle: Theme.of(context).textTheme.headline1!.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .headline1!
                      .color!
                      .withOpacity(0.5),
                )),
        maxLines: 1,
        onChanged: (value) {
          loadedNote.title = value;
          loadedNote.dateCreated = DateTime.now();
          Provider.of<Notes>(context, listen: false).updateNote(loadedNote);
        },
      ),
    );
  }

  // KToolbarHeight, this constant because of the use of the appbar to get the same size 

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
