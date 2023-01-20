import 'package:flutter/material.dart';
import 'package:noti_notes_app/helpers/color_picker.dart';
import 'package:noti_notes_app/helpers/photo_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

import '../widgets/note_creation/tag_creator_manager.dart';
import '../widgets/note_creation/load_create_note.dart';
import '../widgets/items/todo_list_tool.dart';
import '../widgets/items/bottom_tools_item.dart';
import '../widgets/media_grid.dart';
import '../widgets/items/appbar_note_title.dart';
import '../widgets/note_creation/display_selector.dart';

import '../models/note.dart';

import '../../providers/notes.dart';

class NoteViewScreen extends StatefulWidget {
  static const routeName = '/note-view';
  const NoteViewScreen({super.key});

  @override
  State<NoteViewScreen> createState() => _NoteViewScreenState();
}

class _NoteViewScreenState extends State<NoteViewScreen>
    with SingleTickerProviderStateMixin {
  bool _isInit = true;
  File? img;
  Note? importedNote;
  late TabController _tabController;

  var loadedNote = Note(
    {},
    null,
    null,
    [],
    null,
    id: const Uuid().v1(),
    title: '',
    content: '',
    dateCreated: DateTime.now(),
    colorBackground: ColorPicker.defaultColor,
    fontColor: ColorPicker.defaultFontColor,
  );

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

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
              [],
              null,
              id: noteId,
              title: '',
              content: '',
              dateCreated: DateTime.now(),
              colorBackground: ColorPicker.defaultColor,
              fontColor: ColorPicker.defaultFontColor,
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
              PhotoPicker.pickImage,
              loadedNote.id,
              false,
              title: 'Add Image',
              subtitle: 'It will be shown at the top of the note.',
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
            // TagCreator(loadedNote.id),
            TagCreatorManager(loadedNote.id),
          ],
        );
      },
    );
  }

  void openDisplayMode(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (bctx) {
        return Wrap(
          children: [
            DisplaySelector(loadedNote.id),
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
            TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10),
                    child: LoadCreateNote(
                      loadedNote: loadedNote,
                      openMediaPicker: openMediaPicker,
                      removeImage: removeImage,
                      img: img,
                    ),
                  ),
                ),
                TodoListTool(loadedNote.id),
              ],
            ),
            BottomToolsItem(
              pickImage: openMediaPicker,
              addTags: openTagCreator,
              displayMode: openDisplayMode,
              id: loadedNote.id,
              colorBeforeChange: loadedNote.colorBackground, //! TO FIX
              tabController: _tabController,
            ),
          ],
        ),
      ),
    );
  }
}
