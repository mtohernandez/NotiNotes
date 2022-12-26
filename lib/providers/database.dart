import 'package:hive_flutter/hive_flutter.dart';
import '../models/note.dart';

class NotesDataBase {

  Box initBox(String boxName) {
    Box notesBox = Hive.box(boxName);
    return notesBox;
  }

  static disposeBox(Box box) {
    box.close();
  }
}
