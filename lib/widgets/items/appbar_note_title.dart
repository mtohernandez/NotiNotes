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
    final notes = Provider.of<Notes>(context, listen: false);
    return AppBar(
      backgroundColor: Theme.of(context).backgroundColor,
      elevation: 0,
      title: TextFormField(
        maxLength: 20,
        autofocus: loadedNote.title.isEmpty &&
                loadedNote.content.isEmpty &&
                loadedNote.imageFile == null
            ? true
            : false,
        initialValue: loadedNote.title,
        style: Theme.of(context).textTheme.headline1,
        decoration: InputDecoration(
            counterText: '',
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
          notes.updateNote(loadedNote);
        },
        onFieldSubmitted: (value) => FocusScope.of(context).nextFocus(),
      ),
    );
  }

  // KToolbarHeight, this constant because of the use of the appbar to get the same size

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
