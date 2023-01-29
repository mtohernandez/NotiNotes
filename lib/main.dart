import 'package:flutter/material.dart';
import 'package:noti_notes_app/helpers/database_helper.dart';
import 'package:noti_notes_app/screens/home_screen.dart';
import 'package:noti_notes_app/screens/note_view_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import '../api/notifications_api.dart';

import './screens/information_screen.dart';
import './screens/user_info_screen.dart';

import './providers/user_data.dart';
import './providers/notes.dart';
import './providers/search.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xff1D1D1D),
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();

  await LocalNotificationService().setup();

  await DbHelper.initBox(DbHelper.notesBoxName);
  await DbHelper.initBox(DbHelper.userBoxName);

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

  //? The box needs to be disposed after closing the app

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    notes = Notes();
    userData = UserData();
    notes.loadNotesFromDataBase();
    userData.loadUserFromDataBase();
    notes.sortByDateCreated();
    if (userData.curentUserData.name != '') {
      userData.randomGreetings(userData.curentUserData);
    }
    super.initState();
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
        home: HomeScreen(),
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          InformationScreen.routeName: (context) => const InformationScreen(),
          NoteViewScreen.routeName: (context) => const NoteViewScreen(),
          UserInfoScreen.routeName: (context) => const UserInfoScreen(),
        },
      ),
    );
  }
}
