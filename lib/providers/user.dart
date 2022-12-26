import 'package:flutter/material.dart';
import 'dart:io';

import 'package:uuid/uuid.dart';

class User {
  String id = const Uuid().v4();
  String name;
  DateTime bornDate;
  int notesCreated;
  String favoriteColor;
  File? profilePicture;

  User(
    this.profilePicture,
    this.id, 
    this.favoriteColor,
    {
    required this.name,
    required this.bornDate,
    required this.notesCreated,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'bornDate': bornDate.toIso8601String(),
      'notesCreated': notesCreated,
      'profilePicture': profilePicture?.path,
    };
  }
}

class UserData with ChangeNotifier {
  User currentUser =
      User(null, const Uuid().v4(), 'Green', name: 'Mateo', bornDate: DateTime.now(), notesCreated: 234);
  User get curentUserData => currentUser;

  void updateProfilePicture(File? profilePicture) {
    currentUser.profilePicture = profilePicture;
    notifyListeners();
  }

  void updateName(String name) {
    currentUser.name = name;
    notifyListeners();
  }

  //TODO add updateBornDate

  void updateNotesCreated(int notesCreated) {
    currentUser.notesCreated = notesCreated;
    notifyListeners();
  }

  void updateFavoriteColor(String favoriteColor) {
    currentUser.favoriteColor = favoriteColor;
    notifyListeners();
  }


}
