import 'package:flutter/material.dart';
import 'package:noti_notes_app/providers/photo_picker.dart';
import 'package:noti_notes_app/widgets/note_creation/tag_creator.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

import '../models/note.dart';
import '../widgets/note_creation/load_create_note.dart';
import '../widgets/items/bottom_tools_item.dart';
import '../widgets/media_grid.dart';
import '../widgets/items/appbar_note_title.dart';
import '../../providers/notes.dart';

class NoteViewScreen extends StatefulWidget {
  static const routeName = '/note-view';
  const NoteViewScreen({super.key});

  @override
  State<NoteViewScreen> createState() => _NoteViewScreenState();
}

class _NoteViewScreenState extends State<NoteViewScreen> {
  bool _isInit = true;
  File? img;
  Note? importedNote;
  PhotoPicker photoPicker = PhotoPicker();

  var loadedNote = Note(
    {},
    null,
    null,
    id: const Uuid().v1(),
    title: '',
    content: '',
    dateCreated: DateTime.now(),
    colorBackground: Colors.pink,
  );

  @override
  void didChangeDependencies() {
    if (_isInit) {
      if (ModalRoute.of(context)!.settings.arguments != null) {
        String noteId = ModalRoute.of(context)!.settings.arguments as String;

        if (noteId.isNotEmpty) {
          importedNote =
              Provider.of<Notes>(context, listen: false).findByIdOrNull(noteId);
          if (importedNote == null) {
            loadedNote = Note(
              {},
              null,
              null,
              id: noteId,
              title: '',
              content: '',
              dateCreated: DateTime.now(),
              colorBackground: Colors.pink,
            );
            Provider.of<Notes>(context, listen: false).addNote(loadedNote);
          } else {
            loadedNote = importedNote!;
          }
        }
      }
      // if (loadedNote.title.isEmpty &&
      //     loadedNote.content.isEmpty &&
      //     loadedNote.imageFile == null) {
      //   Provider.of<Notes>(context, listen: false)
      //       .removeNoteById(loadedNote.id);
      // }
      _isInit = false;
    }
    super.didChangeDependencies();
  }
  
  void openMediaPicker(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (bctx) {
        return Wrap(
          children: [
            MediaGrid(
              photoPicker.pickImage,
              loadedNote.id,
              false,
            ),
          ],
        );
      },
    );
  }

  void openTagCreator(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (bctx) {
        return Wrap(
          children: [
            TagCreator(loadedNote.id),
          ],
        );
      },
    );
  }

  void removeImage() {
    Provider.of<Notes>(context, listen: false)
        .removeImageFromNote(loadedNote.id);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBarNoteTitle(loadedNote: loadedNote),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                child: LoadCreateNote(
                  loadedNote: loadedNote,
                  openMediaPicker: openMediaPicker,
                  removeImage: removeImage,
                  img: img,
                ),
              ),
            ),
            BottomToolsItem(
              pickImage: openMediaPicker,
              addTags: openTagCreator,
              id: loadedNote.id,
              colorBeforeChange: loadedNote.colorBackground,
            ),
          ],
        ),
      ),
    );
  }
}
