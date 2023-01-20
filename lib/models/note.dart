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

  List<Map<String, dynamic>> todoList;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title.isEmpty ? '' : title,
      'content': title.isEmpty ? '' : content,
      'tags': tags.toList(),
      'dateCreated': dateCreated.toIso8601String(),
      'reminder': reminder?.toIso8601String() ?? '',
      'colorBackground': colorBackground.value,
      'fontColor': fontColor.value,
      'imageFile': imageFile?.path,
      'patternImage': patternImage,
      'todoList': todoList,
      'displayMode': displayMode.index,
    };
  }

  Note(
    this.tags,
    this.imageFile,
    this.patternImage,
    this.todoList,
    this.reminder, {
    required this.id,
    required this.title,
    required this.content,
    required this.dateCreated,
    required this.colorBackground,
    required this.fontColor,
    this.displayMode = DisplayMode.normal,
  });
}
