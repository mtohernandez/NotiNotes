import 'package:flutter/material.dart';
import 'dart:io';

class Note {
  final String id;
  String title;
  String content;
  final Set<String> tags;
  DateTime dateCreated;
  final File? imageFile;
  final Color colorBackground;

  Note(
    this.tags,
    this.imageFile, {
    required this.id,
    required this.title,
    required this.content,
    required this.dateCreated,
    required this.colorBackground,
  });
}
