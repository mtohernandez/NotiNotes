import 'package:flutter/material.dart';
import 'package:noti_notes_app/screens/note_view_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screens/information_screen.dart';
import './screens/notes_overview_screen.dart';
import './screens/user_info_screen.dart';

import './providers/user.dart';
import './providers/notes.dart';
import './providers/search.dart';
import './providers/data_base.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xff1D1D1D),
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  DataBase dataBase = DataBase();
  String notesBoxName = 'notes';
  String userBoxName = 'user';
  await Hive.initFlutter();
  await Hive.openBox(notesBoxName);
  await Hive.openBox(userBoxName);
  Box notesBox = dataBase.initBox(notesBoxName);
  Box userBox = dataBase.initBox(userBoxName);

  runApp(MyApp(notesBox, userBox));
}

class MyApp extends StatefulWidget {
  final Box notesBox;
  final Box userBox;
  const MyApp(this.notesBox, this.userBox, {super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late Notes notes;
  late UserData userData;

  //? The box needs to be disposed after closing the app

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    notes = Notes(widget.notesBox);
    userData = UserData(widget.userBox);
    notes.loadNotesFromDataBase();
    userData.loadUserFromDataBase();
    if (userData.curentUserData.name != '') {
      userData.randomGreetings(userData.curentUserData);
    }
    super.initState();
  }

  // These savings dont really work or Ive noticed that they dont
  // But diposing the box does work

  @override
  void dispose() {
    notes.updateNotesOnDataBase(notes.notes);
    userData.saveUserToDataBase(userData.curentUserData);
    notes.disposeBox(widget.notesBox);
    userData.disposeBox(widget.userBox);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // These do work

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      notes.updateNotesOnDataBase(notes.notes);
      userData.saveUserToDataBase(userData.curentUserData);
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => userData,
        ),
        ChangeNotifierProvider(
          create: (_) => notes,
        ),
        ChangeNotifierProvider(
          create: (_) => Search(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NotiNotes',
        theme: ThemeData(
          fontFamily: 'SF Pro Display',
          primaryColor: Colors.white,
          backgroundColor: const Color(0xff1D1D1D),
          colorScheme: ColorScheme.fromSwatch(
                  // primarySwatch: Colors.grey,
                  )
              .copyWith(
            secondary: const Color(0xff1D1D1D),
          ),
          textTheme: TextTheme(
            headline1: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
            headline2: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
            headline3: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            headline4: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            bodyText1: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            bodyText2: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        home: const NotesOverviewScreen(),
        routes: {
          NotesOverviewScreen.routeName: (context) =>
              const NotesOverviewScreen(),
          InformationScreen.routeName: (context) => const InformationScreen(),
          NoteViewScreen.routeName: (context) => const NoteViewScreen(),
          UserInfoScreen.routeName: (context) => UserInfoScreen(),
        },
      ),
    );
  }
}
