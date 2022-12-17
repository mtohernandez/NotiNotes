import 'package:flutter/material.dart';

class Note {
  final String id;
  final String title;
  final String content;
  final Set<String> tags;
  final DateTime dateCreated;
  final String imageUrl;
  final Color colorBackground;

  Note(
    this.tags,
    this.imageUrl, {
    required this.id,
    required this.title,
    required this.content,
    required this.dateCreated,
    required this.colorBackground,
  });
}
