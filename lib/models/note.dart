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
