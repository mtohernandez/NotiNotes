import 'package:flutter/material.dart';
import 'package:string_similarity/string_similarity.dart';
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

  List<Note> filterByTitle(String name) {
    return _notes.where((note) => note.title.similarityTo(name) > 0.6 ? true : false).toList();
  }
}
