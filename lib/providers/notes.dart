import 'package:flutter/material.dart';
import '../models/note.dart';

class Notes with ChangeNotifier {
  final List<Note> _notes = [
    Note(
      [],
      '',
      id: '1',
      title: 'My duties',
      content:
          'This note is amazingly created by me, the new world is rising in these notes. Crazy to think about it.',
      dateCreated: DateTime.now(),
    ),
    Note(
      ['home', 'work', 'school', 'personal', 'work', 'school', 'personal'],
      '',
      id: '2',
      title: 'Two Duties on top',
      content:
          'This note is amazingly created by me, the new world is rising in these notes. Crazy to think about it.Crazy to think about it.Crazy to think about it. Crazy to think about it. Crazy to think about it. Crazy to think about it. Crazy to think about it.',
      dateCreated: DateTime.now(),
    ),
    Note(
      ['home'],
      '',
      id: '3',
      title: 'My duties',
      content:
          'This note is amazingly created by me, the new world is rising in these notes. Crazy to think about it.',
      dateCreated: DateTime.now(),
    ),
    Note(
      ['duties', 'atention'],
      '',
      id: '4',
      title: 'Two Duties',
      content:
          'This note is amazingly created by me, the new world is rising in these notes. Crazy to think about it.Crazy to think about it.Crazy to think about it. Crazy to think about it. Crazy to think about it. Crazy to think about it. Crazy to think about it.',
      dateCreated: DateTime.now(),
    ),
  ]; // Should be final? Not really

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
