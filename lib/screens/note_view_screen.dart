import 'package:flutter/material.dart';
import 'package:noti_notes_app/models/note.dart';
import 'package:noti_notes_app/widgets/note_creation/load_create_note.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

import '../widgets/media_grid.dart';
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
  final ImagePicker _picker = ImagePicker();

  var loadedNote = Note(
    {},
    null,
    id: const Uuid().v1(),
    title: '',
    content: '',
    dateCreated: DateTime.now(),
    colorBackground: Colors.black,
  );

  @override
  void didChangeDependencies() {
    if (_isInit) {
      if (ModalRoute.of(context)!.settings.arguments != null) {
        String noteId = ModalRoute.of(context)!.settings.arguments as String;

        if (noteId.isNotEmpty) {
          loadedNote =
              Provider.of<Notes>(context, listen: false).findById(noteId);
        }
      }
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await _picker.pickImage(source: source);
      if (image == null) return;
      setState(
        () {
          img = File(image.path);
          Navigator.of(context).pop();
        },
      );
    } on Exception catch (e) {
      Navigator.of(context).pop();
    }
  }

  void _openMediaPicker(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (bctx) {
        return Wrap(
          children: [
            MediaGrid(pickImage),
          ],
        );
      },
    );
  }

  void removeImage() {
    setState(() {
      img = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0,
          title: TextFormField(
            autofocus: loadedNote.title.isEmpty ? true : false,
            initialValue: loadedNote.title,
            style: Theme.of(context).textTheme.headline1,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            maxLines: 1,
            onChanged: (value) {
              loadedNote.title = value;
              loadedNote.dateCreated = DateTime.now();
              Provider.of<Notes>(context, listen: false).updateNote(loadedNote);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
            child: LoadCreateNote(
              loadedNote: loadedNote,
              openMediaPicker: _openMediaPicker,
              removeImage: removeImage,
              img: img,
            ),
          ),
        ),
      ),
    );
  }
}
