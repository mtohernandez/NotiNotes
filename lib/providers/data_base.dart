import 'package:hive_flutter/hive_flutter.dart';

class DataBase {

  Box initBox(String boxName) {
    Box notesBox = Hive.box(boxName);
    return notesBox;
  }
  
}
