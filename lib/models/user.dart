import 'dart:io';
import 'package:uuid/uuid.dart';

class User {
  String id = const Uuid().v4(); 
  String name;
  DateTime bornDate;
  // String favoriteColor;
  File? profilePicture;

  User(
    this.profilePicture,
    this.id, {
    required this.name,
    required this.bornDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'bornDate': bornDate.toIso8601String(),
      'profilePicture': profilePicture?.path,
    };
  }
}