import 'package:flutter/material.dart';
import 'dart:io';


// How this works:
/*
* withTodoList: The todo list with all the contents except the image
* withImage: The image without the todo list and the content normal
* withoutContent: The image the title no content and no todo list
* normal: normal displaying without todo list and all elements
*/



enum DisplayMode {
  withTodoList,
  withImage,
  withoutContent,
  normal
}

class Note {
  final String id;
  String title;
  String content;
  Set<String> tags;
  DateTime dateCreated;
  DateTime? reminder;
  File? imageFile;
  Color colorBackground;
  Color fontColor;
  String? patternImage;
  DisplayMode displayMode;
  bool hasGradient;
  LinearGradient? gradient;
  bool isPinned;
  int? sortIndex;

  /// New unified editor block list. Each block is a map with a 'type' key
  /// (one of 'text', 'checklist', 'image') plus type-specific fields.
  /// New notes use this exclusively; legacy notes use content/todoList/imageFile.
  List<Map<String, dynamic>> blocks;

  List<Map<String, dynamic>> todoList;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title.isEmpty ? '' : title,
      'content': title.isEmpty ? '' : content,
      'tags': tags.toList(),
      'dateCreated': dateCreated.toIso8601String(),
      'reminder': reminder?.toIso8601String() ?? '',
      'colorBackground': colorBackground.toARGB32(),
      'fontColor': fontColor.toARGB32(),
      'imageFile': imageFile?.path,
      'patternImage': patternImage,
      'todoList': todoList,
      'displayMode': displayMode.index,
      'hasGradient': hasGradient,
      'gradient': gradient == null ? '' : {'colors': gradient?.colors.map((e) => e.toARGB32()).toList(), 'alignment': [gradient!.begin.toString(), gradient!.end.toString()]},
      'isPinned': isPinned,
      'sortIndex': sortIndex,
      'blocks': blocks,
    };
  }

  Note(
    this.tags,
    this.imageFile,
    this.patternImage,
    this.todoList,
    this.reminder,
    this.gradient, {
    required this.id,
    required this.title,
    required this.content,
    required this.dateCreated,
    required this.colorBackground,
    required this.fontColor,
    required this.hasGradient,
    this.displayMode = DisplayMode.normal,
    this.isPinned = false,
    this.sortIndex,
    List<Map<String, dynamic>>? blocks,
  }) : blocks = blocks ?? [];
}
