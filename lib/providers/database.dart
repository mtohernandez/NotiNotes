import 'package:hive_flutter/hive_flutter.dart';
import '../models/note.dart';

class NotesDataBase {

  Box initBox(String boxName) {
    Box notesBox = Hive.box(boxName);
    return notesBox;
  }

  static List<Note> initNotes() {
    final notesBox = Hive.box('notes');
    return notesBox.values
        .map(
          (note) => Note.fromJson(note),
        )
        .toList();
  }

  static updateNotes(List<Note> notes) {
    final notesBox = Hive.box('notes');
    notes.map(
      (note) => notesBox.put(
        note.id,
        note.toJson(),
      ),
    );
  }

  static disposeBox(Box box) {
    box.close();
  }
}
