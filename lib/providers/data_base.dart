import 'package:hive_flutter/hive_flutter.dart';

class NotesDataBase {

  Box initBox(String boxName) {
    Box notesBox = Hive.box(boxName);
    return notesBox;
  }
  
}
