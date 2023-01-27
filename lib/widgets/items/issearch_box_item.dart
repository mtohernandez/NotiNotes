import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:noti_notes_app/providers/notes.dart';

class IsSearchBoxItem extends StatelessWidget {
  const IsSearchBoxItem({super.key});

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<Notes>(context, listen: false);

    return Row(
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
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
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
    );
  }
}
