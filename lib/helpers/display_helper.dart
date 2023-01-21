import '../models/note.dart';

class DisplayModes {
  static Map<String, String> getDisplayMode(DisplayMode mode) {
    switch (mode) {
      case DisplayMode.normal:
        return {
          'display': 'Normal',
          'description': 'Title + Content',
        };
      case DisplayMode.withImage:
        return {
          'display': 'With Image',
          'description': 'Image  + Title + Content + Tags'
        };
      case DisplayMode.withTodoList:
        return {
          'display': 'With Todo List',
          'description': 'Title + Todo List + Tags'
        };
      case DisplayMode.withoutContent:
        return {
          'display': 'Without Content',
          'description': 'Title + Tags',
        };
      default:
        return {
          'display': 'Normal',
          'description': 'Title + Content + Tags',
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
    },
    {
      'display': DisplayMode.withTodoList,
      'asset': 'lib/assets/icons/todolistDisplay.svg',
    },
    {
      'display': DisplayMode.withoutContent,
      'asset': 'lib/assets/icons/contentDisplay.svg',
    },
  ];
}
