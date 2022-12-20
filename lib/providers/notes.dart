import 'package:flutter/material.dart';
import 'package:string_similarity/string_similarity.dart';
import 'dart:io';

import '../models/note.dart';

class Notes with ChangeNotifier {
  final List<Note> _notes = [];
  bool editMode = false;
  Set<String> notesToDelete = {};

  List<Note> get notes {
    return [..._notes];
  }

  bool get isEditMode {
    return editMode;
  }

  void activateEditMode() {
    editMode = true;
    notifyListeners();
  }

  void deactivateEditMode() {
    editMode = false;
    notifyListeners();
  }

  void addNote(Note note) {
    if (note.id.isEmpty) {
      return;
    }
    _notes.add(note);
    notifyListeners();
  }

  void removeSelectedNotes(Set<String> ids) {
    _notes.removeWhere((note) => ids.contains(note.id));
    notifyListeners();
  }

  void updateNote(
    Note noteUpdated,
  ) {
    final noteIndex = _notes.indexWhere((note) => note.id == noteUpdated.id);
    if (noteIndex >= 0) {
      _notes[noteIndex] = noteUpdated;
      notifyListeners();
    }
  }

  List<Note> filterByTitle(String name) {
    return _notes
        .where((note) => note.title.similarityTo(name) > 0.6 ? true : false)
        .toList();
  }

  // List<Note> filterByTag(String tag) {
  //   return _notes
  //       .where((note) => note.tags.contains(tag) ? true : false)
  //       .toList();
  // }

  List<Note> filterByTag(Set<String> tags) {
    // Since it is a set we can use intersection to find the common elements between the two sets and return a new set with the common elements.

    return _notes
        .where((note) => note.tags.intersection(tags).isNotEmpty ? true : false)
        .toList();
  }

  Note findById(String id) {
    return _notes.firstWhere((note) => note.id == id);
  }
}
