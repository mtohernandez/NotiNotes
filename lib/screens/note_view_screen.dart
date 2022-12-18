import 'package:flutter/material.dart';
import 'package:noti_notes_app/models/note.dart';
import 'package:provider/provider.dart';

import '../../providers/notes.dart';

class NoteViewScreen extends StatefulWidget {
  static const routeName = '/note-view';
  const NoteViewScreen({super.key});

  @override
  State<NoteViewScreen> createState() => _NoteViewScreenState();
}

class _NoteViewScreenState extends State<NoteViewScreen> {
  bool _isInit = true;

  var _loadedNote = Note(
    {},
    null,
    id: '',
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
          _loadedNote =
              Provider.of<Notes>(context, listen: false).findById(noteId);
        }
      }
      _isInit = false;
    }
    super.didChangeDependencies();
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
            initialValue: _loadedNote.title,
            style: Theme.of(context).textTheme.headline1,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            maxLines: 1,
            onChanged: (value) {
              _loadedNote.title = value;
              Provider.of<Notes>(context, listen: false)
                  .updateNote(_loadedNote);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
            child: Column(
              children: [
                if (_loadedNote.imageFile != null)
                  Hero(
                    tag: 'noteImage${_loadedNote.id}',
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: double.infinity,
                      color: Theme.of(context).backgroundColor,
                      child: Image.file(
                        _loadedNote.imageFile!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                TextFormField(
                  maxLines: null, // Lol this works
                  keyboardType: TextInputType.multiline,
                  initialValue: _loadedNote.content,
                  style: Theme.of(context).textTheme.bodyText1,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).unfocus();
                  },
                  onChanged: (value) {
                    _loadedNote.content = value;
                    Provider.of<Notes>(context, listen: false)
                        .updateNote(_loadedNote);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
