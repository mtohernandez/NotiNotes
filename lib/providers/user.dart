import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
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

class UserData with ChangeNotifier {
  User currentUser = User(
    null,
    const Uuid().v4(),
    name: '',
    bornDate: DateTime.now(),
  );

  var _greetingToUser = 'NotiNotes'; // Default greeting

  Box userBox;

  UserData(this.userBox);

  User get curentUserData => currentUser;

  String get greetingToUser => _greetingToUser;

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

  void randomGreetings(User user) {
    var currentDay = DateFormat('EEEE').format(DateTime.now());
    var greetings = [];

    greetings = [
      'Good ${greeting()}',
      'Today is the day.',
      '${user.name == '' ? 'User' : user.name.toLowerCase()}, glad you\'re back.',
      'You\'re doing great.',
      'Good ${greeting()} ${user.name == '' ? 'User' : user.name.toLowerCase()}',
      'Plans for the weekend?',
      '${user.name == '' ? 'User' : user.name.toLowerCase()}, did you shower?',
      'Tonight\'s the night.',
      'This is your notinotes.',
    ];

    if (currentDay == 'Monday') {
      greetings = [
        'Another monday, ugh...',
        'Starting the week.',
        'Let\'s get things done.',
        '${user.name == '' ? 'User' : user.name.toLowerCase()}, you\'ll crush it.',
      ];
    }

    if (currentDay == 'Tuesday') {
      greetings = [
        'Tuesday, not monday.',
        'Taco tuesday?',
        'today is... not monday!',
        '${user.name == '' ? 'User' : user.name.toLowerCase()}, feeling good?',
      ];
    }

    var random = Random();
    var element = greetings[random.nextInt(greetings.length)];
    _greetingToUser = element;
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
