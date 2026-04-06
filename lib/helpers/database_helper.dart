import 'package:hive_ce_flutter/hive_flutter.dart';

class DbHelper {
  // v2 boxes — bumped from v1 to wipe legacy storage on first launch of the
  // redesigned app. Old `notes` and `user` boxes are simply ignored.
  static String notesBoxName = 'notes_v2';
  static String userBoxName = 'user_v2';
  static String settingsBoxName = 'settings_v2';

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
