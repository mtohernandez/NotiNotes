import 'package:flutter/material.dart';
import '../models/note.dart';

class Notes with ChangeNotifier {
  final List<Note> _notes = []; 

  List<Note> get notes {
    return [..._notes];
  }

  void addNote(Note note) {
    if (note.id.isEmpty) {
      return;
    }
    _notes.add(note);
    notifyListeners();
  }

  void removeNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }
}
