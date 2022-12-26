import 'package:flutter/material.dart';
import 'package:noti_notes_app/screens/note_view_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './screens/login_screen.dart';
import './screens/notes_overview_screen.dart';

import './providers/notes.dart';
import './providers/search.dart';
import 'providers/database.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xff1D1D1D),
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  NotesDataBase notesDataBase = NotesDataBase();
  String notesBoxName = 'notes';
  await Hive.initFlutter();
  await Hive.openBox(notesBoxName);
  Box notesBox = notesDataBase.initBox(notesBoxName);

  runApp(MyApp(notesBox));
}

class MyApp extends StatefulWidget {
  final Box notesBox;
  const MyApp(this.notesBox, {super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late Notes notes;
  //? The box needs to be disposed after closing the app

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    notes = Notes(widget.notesBox);
    notes.loadNotesFromDataBase();
    super.initState();
  }

  @override
  void dispose() {
    notes.updateNotesOnDataBase(notes.notes);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      notes.updateNotesOnDataBase(notes.notes);
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
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
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: const Color(0xff1D1D1D),
          ),
          textTheme: TextTheme(
            headline1: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
            headline2: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w700,
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
          NotesOverviewScreen.routeName: (context) => NotesOverviewScreen(),
          LoginSignupScreen.routeName: (context) => LoginSignupScreen(),
          NoteViewScreen.routeName: (context) => NoteViewScreen(),
        },
      ),
    );
  }
}
