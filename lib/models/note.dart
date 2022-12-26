import 'package:flutter/material.dart';
import 'dart:io';


class Note {
  
  final String id;
  String title;
  String content;
  Set<String> tags;
  DateTime dateCreated;
  File? imageFile;
  Color colorBackground;
  File? patternImage;
  

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title.isEmpty ? '' : title,
      'content': title.isEmpty ? '' : content,
      'tags': tags.toList(),
      'dateCreated': dateCreated.toIso8601String(),
      'colorBackground': colorBackground.value,
      'imageFile': imageFile?.path,
      'patternImage': patternImage?.path,
    };
  }

  Note.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        tags = json['tags'].cast<String>().toSet(),
        dateCreated = DateTime.parse(json['dateCreated']),
        colorBackground = Color(json['colorBackground']),
        imageFile = json['imageFile'] != null ? File(json['imageFile']) : null,
        patternImage = json['patternImage'] != null ? File(json['patternImage']) : null;


  Note(
    this.tags,
    this.imageFile, 
    this.patternImage,
    {
    required this.id,
    required this.title,
    required this.content,
    required this.dateCreated,
    required this.colorBackground,
  });
}
