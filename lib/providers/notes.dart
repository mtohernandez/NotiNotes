import 'package:flutter/material.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../models/note.dart';

enum SqueezedMetric {
  superSqueezed,
  squeeezed,
  notSqueezed,
}

enum ToolingNote {
  addTag,
  removeTag,
  addImage,
  removeImage,
  color,
}

class Notes with ChangeNotifier {
  final List<Note> _notes = [];
  final ImagePicker _picker = ImagePicker();
  final Map<SqueezedMetric, int> squeezMetrics = {
    // Testing
    SqueezedMetric.superSqueezed: 3,
    SqueezedMetric.squeeezed: 2,
    SqueezedMetric.notSqueezed: 1,
  };
  bool editMode = false;
  Set<String> notesToDelete = {};

  List<Note> get notes {
    return [..._notes];
  }

  bool get isEditMode {
    return editMode;
  }

  //? Modes on note editing

  void activateEditMode() {
    editMode = true;
    notifyListeners();
  }

  void deactivateEditMode() {
    editMode = false;
    notifyListeners();
  }

  //? Note creation

  void addNote(Note note) {
    if (note.id.isEmpty) {
      return;
    }
    _notes.add(note);
    notifyListeners();
  }

  //? Multiple note deletion

  void removeSelectedNotes(Set<String> ids) {
    _notes.removeWhere((note) => ids.contains(note.id));
    notifyListeners();
  }


  //? Updating single note

  void updateNote(
    Note noteUpdated,
  ) {
    final noteIndex = _notes.indexWhere((note) => note.id == noteUpdated.id);
    if (noteIndex >= 0) {
      _notes[noteIndex] = noteUpdated;
      notifyListeners();
    }
  }


  //? Filtering methods

  List<Note> filterByTitle(String name) {
    return _notes
        .where((note) => note.title.similarityTo(name) > 0.6 ? true : false)
        .toList();
  }

  List<Note> filterByTag(Set<String> tags) {
    return _notes
        .where((note) => note.tags.intersection(tags).isNotEmpty ? true : false)
        .toList();
  }

  Note findById(String id) {
    return _notes.firstWhere((note) => note.id == id);
  }

  int findIndex(String id) {
    return _notes.indexWhere((note) => note.id == id);
  }

  Color findColor(String id) {
    return _notes.firstWhere((note) => note.id == id).colorBackground;
  }


  //? Tooling for note changing

  void toolingNote(String id, ToolingNote tooling, dynamic value, [int index = 0]) {
    final noteIndex = findIndex(id);
    if (noteIndex >= 0) {
      if (tooling == ToolingNote.addImage) {
        _notes[noteIndex].imageFile = File(value.path);
      } else if (tooling == ToolingNote.removeImage) {
        _notes[noteIndex].imageFile = value;
      } else if (tooling == ToolingNote.addTag) {
        _notes[noteIndex].tags.add(value);
      } else if (tooling == ToolingNote.removeTag) {
        _notes[noteIndex].tags.remove(_notes[noteIndex].tags.elementAt(index));
      } else if (tooling == ToolingNote.color) {
        _notes[noteIndex].colorBackground = value;
      }

      notifyListeners();
    }
  }

  void addImageToNote(String id, File image) {
    toolingNote(id, ToolingNote.addImage, image);
  }

  void removeImageFromNote(String id) {
    toolingNote(id, ToolingNote.removeImage, null);
  }

  void addTagToNote(String tag, String id) {
    toolingNote(id, ToolingNote.addTag, tag);
  }

  void removeTagsFromNote(int index, String id) {
    toolingNote(id, ToolingNote.removeTag, null, index);
  }

  void changeCurrentColor(String id, Color color) {
    toolingNote(id, ToolingNote.color, color);
  }

  //? Future methods

  Future<File?> pickImage(ImageSource source, String id) async {
    final image = await _picker.pickImage(source: source);
    if (image == null) return null;
    final imageFromPath = File(image.path);
    return imageFromPath;
  }
}
