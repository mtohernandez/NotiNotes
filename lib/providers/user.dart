import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noti_notes_app/helpers/database_helper.dart';
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

  // After the app is initialized the user is inserted into the database

  Future<void> loadUserFromDataBase() async {
    final dataList = await DbHelper.getData(DbHelper.userTable, DbHelper.databaseUser());

    if (dataList.isEmpty) {
      saveUserToDataBase(currentUser);
    } else {
      currentUser = User(
        dataList[0]['profilePicture'] != null && dataList[0]['profilePicture'] != '' ? File(dataList[0]['profilePicture']) : null,
        dataList[0]['id'],
        name: dataList[0]['name'],
        bornDate: DateTime.parse(dataList[0]['bornDate']),
      );
    }

    notifyListeners();
  }

  void saveUserToDataBase(User currentUser) {
    DbHelper.insert(DbHelper.userTable, {
      'id': currentUser.id,
      'name': currentUser.name,
      'bornDate': currentUser.bornDate.toIso8601String(),
      'profilePicture': currentUser.profilePicture?.path,
    }, DbHelper.databaseUser());
  }

  void updateUserToDataBase(User currentUser) {
    DbHelper.update(DbHelper.userTable, {
      'id': currentUser.id,
      'name': currentUser.name,
      'bornDate': currentUser.bornDate.toIso8601String(),
      'profilePicture': currentUser.profilePicture?.path,
    }, DbHelper.databaseUser());
  }
}
