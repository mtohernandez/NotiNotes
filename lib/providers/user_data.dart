import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:noti_notes_app/helpers/database_helper.dart';
import 'package:noti_notes_app/helpers/photo_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:uuid/uuid.dart';

import '../models/user.dart';

class UserData with ChangeNotifier {
  User currentUser = User(
    null,
    const Uuid().v4(),
    name: '',
    bornDate: DateTime.now(),
  );

  var _greetingToUser = 'NotiNotes'; // Default greeting

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

  void saveUserToDataBase(User currentUser) {
    DbHelper.insertUpdateData(
      DbHelper.userBoxName,
      'userFromDevice',
      jsonEncode(
        currentUser.toJson(),
      ),
    );
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
    saveUserToDataBase(currentUser);
    notifyListeners();
  }

  void updateName(String name) {
    currentUser.name = name;
    saveUserToDataBase(currentUser);

    notifyListeners();
  }

  Future<void> removeProfilePicture() async {
    if(currentUser.profilePicture == null) return;
    await PhotoPicker.removeImage(currentUser.profilePicture!);
    currentUser.profilePicture = null;
    saveUserToDataBase(currentUser);

    notifyListeners();
  }

  void loadUserFromDataBase() {
    Box userBox = DbHelper.getBox(DbHelper.userBoxName);
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
}
