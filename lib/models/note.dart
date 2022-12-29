import 'package:flutter/material.dart';
import 'dart:io';

class Note {
  final String id;
  String title;
  String content;
  Set<String> tags;
  DateTime dateCreated;
  DateTime? reminder;
  File? imageFile;
  Color colorBackground;
  File? patternImage;
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
      'imageFile': imageFile?.path,
      'patternImage': patternImage?.path,
      'todoList': todoList,
    };
  }

  Note(
    this.tags,
    this.imageFile,
    this.patternImage,
    this.todoList, 
    this.reminder,
    {
    required this.id,
    required this.title,
    required this.content,
    required this.dateCreated,
    required this.colorBackground,
  });
}
