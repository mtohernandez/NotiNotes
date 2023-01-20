import '../models/note.dart';

class DisplayModes {
  static Map<String, String> getDisplayMode(DisplayMode mode) {
    switch (mode) {
      case DisplayMode.normal:
        return {
          'display': 'Normal',
          'description': 'Content + Tags + Title'
        };
      case DisplayMode.withImage:
        return {
          'display': 'With Image',
          'description': 'Content + Tags + Title + Image'
        };
      case DisplayMode.withTodoList:
        return {
          'display': 'With Todo List',
          'description': 'Content + Todo List + Title'
        };
      case DisplayMode.withoutContent:
        return {
          'display': 'Without Content',
          'description': 'Tags + Title + Image'
        };
      default:
        return {
          'display': 'Normal',
          'description': 'Content + Tags + Title'
        };
    }
  }

  static List<Map<String, dynamic>> displayModes = [
    {
      'display': DisplayMode.normal,
      'asset': 'lib/assets/icons/normalDisplay.svg',
    },
    {
      'display': DisplayMode.withImage,
      'asset': 'lib/assets/icons/imageDisplay.svg',
      'description': 'Content + Tags + Title + Image'
    },
    {
      'display': DisplayMode.withTodoList,
      'asset': 'lib/assets/icons/todolistDisplay.svg',
      'description': 'Content + Todo List + Title'
    },
    {
      'display': DisplayMode.withoutContent,
      'asset': 'lib/assets/icons/contentDisplay.svg',
      'description': 'Tags + Title + Image'
    },
  ];
}
