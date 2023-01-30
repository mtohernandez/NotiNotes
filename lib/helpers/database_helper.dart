import 'package:hive_flutter/hive_flutter.dart';

class DbHelper {
  static String notesBoxName = 'notes';
  static String userBoxName = 'user';

  static Future<void> initBox(String boxName) async {
    await Hive.initFlutter();
    await Hive.openBox(boxName);
  }

  static Box getBox(String boxName) {
    return Hive.box(boxName);
  }

  static Future<void> insertUpdateData(
      String boxName, String key, dynamic value) async {
    await Hive.box(boxName).put(key, value);
  }

  static Future<void> deleteData(String boxName, String key) async {
    await Hive.box(boxName).delete(key);
  }

  static Future<void> closeBox(String boxName) async {
    await Hive.box(boxName).close();
  }

  static Future<void> deleteBox(String boxName) async {
    await Hive.deleteBoxFromDisk(boxName);
  }

  static Future<void> deleteAllBoxes() async {
    await Hive.deleteFromDisk();
  }

  static Future<void> clearBox(String boxName) async {
    await Hive.box(boxName).clear();
  }
}
