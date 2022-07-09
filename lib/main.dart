import 'package:data_base/DataBase/DB_Controller.dart';
import 'package:data_base/Storage/Pref_Controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'DataBase/Providers/note_provider.dart';
import 'DataBase/Providers/user_provider.dart';
import 'Screen/App/Note_Screen.dart';
import 'Screen/App/Notes_Screen.dart';
import 'Screen/Login_Screen.dart';
import 'Screen/Lunch_Screen.dart';
import 'Screen/Register_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefController().initPrefController();
  await DBController().initDataBase();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider()),
        ChangeNotifierProvider<NoteProvider>(
            create: (context) => NoteProvider()),
      ],
      child: MaterialApp(
        initialRoute: '/LunchScreen',
        routes: {
          '/LunchScreen': (context) => const LunchScreen(),
          '/LoginScreen': (context) => const LoginScreen(),
          '/RegisterScreen': (context) => const RegisterScreen(),
          '/NotesScreen': (context) => const NotesScreen(),
          '/NoteScreen': (context) => const NoteScreen(),
        },
      ),
    );
  }
}
