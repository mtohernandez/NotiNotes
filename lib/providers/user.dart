import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:uuid/uuid.dart';

class User {
  String id = const Uuid().v4();
  String name;
  DateTime bornDate;
  // String favoriteColor;
  File? profilePicture;

  User(
    this.profilePicture,
    this.id,
    {
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

class UserData with ChangeNotifier {
  User currentUser = User(
    null,
    const Uuid().v4(),
    name: '',
    bornDate: DateTime.now(),
  );

  Box userBox;

  UserData(this.userBox);

  User get curentUserData => currentUser;

  String get greetingToUser => _randomGreetings(currentUser);

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  String _randomGreetings(User user) {
    var greetings = [
      'Good ${greeting()}',
      'Today is the day.',
      '${user.name == '' ? 'User' : user.name.toLowerCase()}, glad you\'re back.',
      'You\'re doing great.',
      'Good ${greeting()} ${user.name == '' ? 'User' : user.name.toLowerCase()}',
      'Plans for the weekend?',
      '${user.name == '' ? 'User' : user.name.toLowerCase()} is the best.',
      'Tonight\'s the night.',
      'This is your notinotes.',
    ];
    var random = Random();
    var element = greetings[random.nextInt(greetings.length)];
    return element;
  }

  void updateProfilePicture(File? profilePicture) {
    currentUser.profilePicture = profilePicture;
    notifyListeners();
  }

  void updateName(String name) {
    currentUser.name = name;
    notifyListeners();
  }

  void removeProfilePicture() {
    currentUser.profilePicture = null;
    notifyListeners();
  }

  //TODO add updateBornDate

  // void updateFavoriteColor(String favoriteColor) {
  //   currentUser.favoriteColor = favoriteColor;
  //   notifyListeners();
  // }

  void loadUserFromDataBase() {
    if (userBox.values.isEmpty) {
      return;
    }

    var userDecoded = jsonDecode(userBox.values.first);
    currentUser = User(
      userDecoded['profilePicture'] != null
          ? File(userDecoded['profilePicture'])
          : null,
      userDecoded['id'],
      // userDecoded['favoriteColor'],
      name: userDecoded['name'],
      bornDate: DateTime.parse(
        userDecoded['bornDate'],
      ),
    );

    notifyListeners();
  }

  void saveUserToDataBase(User currentUser) {
    userBox.put(
      'userFromDevice',
      jsonEncode(
        currentUser.toJson(),
      ),
    );
  }

  void disposeBox(Box box) {
    box.close();
  }
}
