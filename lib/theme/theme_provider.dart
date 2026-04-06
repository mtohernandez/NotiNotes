import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import 'app_typography.dart';

/// Stores the user's chosen theme mode and writing font, persisted to a
/// dedicated Hive box (`settings_v2`).
class ThemeProvider with ChangeNotifier {
  static const String _boxName = 'settings_v2';
  static const String _themeModeKey = 'themeMode';
  static const String _writingFontKey = 'writingFont';

  ThemeMode _themeMode = ThemeMode.system;
  WritingFont _writingFont = WritingFont.inter;

  ThemeMode get themeMode => _themeMode;
  WritingFont get writingFont => _writingFont;

  static Future<void> ensureBoxOpen() async {
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.openBox(_boxName);
    }
  }

  void load() {
    final box = Hive.box(_boxName);
    final modeIndex = box.get(_themeModeKey, defaultValue: ThemeMode.system.index) as int;
    _themeMode = ThemeMode.values[modeIndex];
    final fontIndex = box.get(_writingFontKey, defaultValue: WritingFont.inter.index) as int;
    _writingFont = WritingFont.values[fontIndex];
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    _themeMode = mode;
    await Hive.box(_boxName).put(_themeModeKey, mode.index);
    notifyListeners();
  }

  Future<void> setWritingFont(WritingFont font) async {
    if (_writingFont == font) return;
    _writingFont = font;
    await Hive.box(_boxName).put(_writingFontKey, font.index);
    notifyListeners();
  }
}
