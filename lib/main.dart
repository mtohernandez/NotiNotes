import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:noti_notes_app/helpers/database_helper.dart';
import 'package:noti_notes_app/screens/home_screen.dart';
import 'package:noti_notes_app/screens/note_editor_screen.dart';
import 'package:noti_notes_app/screens/settings_screen.dart';
import 'package:noti_notes_app/theme/app_theme.dart';
import 'package:noti_notes_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

import 'package:noti_notes_app/api/notifications_api.dart';

import './screens/user_info_screen.dart';

import './providers/user_data.dart';
import './providers/notes.dart';
import './providers/search.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DbHelper.initBox(DbHelper.notesBoxName);
  await DbHelper.initBox(DbHelper.userBoxName);
  await ThemeProvider.ensureBoxOpen();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late Notes notes;
  late UserData userData;
  late ThemeProvider themeProvider;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    notes = Notes();
    userData = UserData();
    themeProvider = ThemeProvider()..load();
    notes.loadNotesFromDataBase();
    userData.loadUserFromDataBase();
    notes.sortByDateCreated();
    if (userData.curentUserData.name != '') {
      userData.randomGreetings(userData.curentUserData);
    }

    Future.delayed(Duration.zero).then(
      (_) {
        LocalNotificationService.setup(notificationResponse).asStream().listen(
              (event) => notificationResponse,
            );
      },
    );
    super.initState();
  }

  void notificationResponse(NotificationResponse response) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NoteEditorScreen(noteId: response.payload),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => userData),
        ChangeNotifierProvider(create: (_) => notes),
        ChangeNotifierProvider(create: (_) => Search()),
        ChangeNotifierProvider.value(value: themeProvider),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, theme, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'NotiNotes',
            theme: AppTheme.light(theme.writingFont),
            darkTheme: AppTheme.dark(theme.writingFont),
            themeMode: theme.themeMode,
            home: const HomeScreen(),
            routes: {
              HomeScreen.routeName: (context) => const HomeScreen(),
              NoteEditorScreen.routeName: (context) => const NoteEditorScreen(),
              UserInfoScreen.routeName: (context) => const UserInfoScreen(),
              SettingsScreen.routeName: (context) => const SettingsScreen(),
            },
          );
        },
      ),
    );
  }
}
