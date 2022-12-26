import 'package:flutter/material.dart';
import 'dart:io';

class User with ChangeNotifier {
  final String id;
  String name;
  final String age;
  final int notesCreated;
  File? profilePicture;

  User(
    this.profilePicture,
    {
    required this.id,
    required this.name,
    required this.age,
    required this.notesCreated,
  });
}
