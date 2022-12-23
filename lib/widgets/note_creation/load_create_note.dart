import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../../providers/notes.dart';
import '../../models/note.dart';

class LoadCreateNote extends StatelessWidget {
  final Note loadedNote;
  final Function openMediaPicker;
  final Function removeImage;
  final File? img;
  const LoadCreateNote(
      {required this.loadedNote,
      required this.openMediaPicker,
      required this.removeImage,
      required this.img,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (loadedNote.imageFile != null)
          Hero(
            tag: 'noteImage${loadedNote.id}',
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: double.infinity,
              color: Theme.of(context).backgroundColor,
              child: Image.file(
                loadedNote.imageFile!,
                fit: BoxFit.cover,
              ),
            ),
          ),
        TextFormField(
          maxLines: null, // Lol this works
          keyboardType: TextInputType.multiline,
          initialValue: loadedNote.content,
          style: Theme.of(context).textTheme.bodyText1,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          onFieldSubmitted: (value) {
            FocusScope.of(context).unfocus();
          },
          onChanged: (value) {
            loadedNote.content = value;
            loadedNote.dateCreated = DateTime.now();
            Provider.of<Notes>(context, listen: false).updateNote(loadedNote);
          },
        ),
      ],
    );
  }
}
