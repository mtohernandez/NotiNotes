import 'package:flutter/material.dart';
import 'package:noti_notes_app/screens/note_view_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import './screens/login_screen.dart';
import './screens/notes_overview_screen.dart';

import './providers/notes.dart';
import './providers/search.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xff1D1D1D),
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Notes(),
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
        initialRoute: NotesOverviewScreen.routeName,
        routes: {
          NotesOverviewScreen.routeName: (context) => NotesOverviewScreen(),
          LoginSignupScreen.routeName: (context) => LoginSignupScreen(),
          NoteViewScreen.routeName: (context) => NoteViewScreen(),
        },
      ),
    );
  }
}
