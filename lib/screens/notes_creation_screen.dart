import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../widgets/note_creation/form_note_creation.dart';
import '../widgets/media_grid.dart';

class NotesCreationScreen extends StatefulWidget {
  static const routeName = '/note-creation';
  NotesCreationScreen({super.key});

  @override
  State<NotesCreationScreen> createState() => _NotesCreationScreenState();
}

class _NotesCreationScreenState extends State<NotesCreationScreen> {
  File? img;
  final ImagePicker _picker = ImagePicker();

  Future _pickImage(ImageSource source) async {
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
      // Show error message;
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
            MediaGrid(_pickImage),
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
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: FormNoteCreation(_openMediaPicker, img, removeImage),
        ),
      ),
    );
  }
}
