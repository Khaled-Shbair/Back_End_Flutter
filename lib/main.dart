import 'package:data_base/DataBase/DB_Controller.dart';
import 'package:data_base/DataBase/bloc/bloc/NoteBloc.dart';
import 'package:data_base/Storage/Pref_Controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'API/screen/forget_password_screen.dart';
import 'API/screen/login_screen.dart';
import 'API/screen/lunch_screen.dart';
import 'API/screen/register_screen.dart';
import 'API/screen/reset_password_screen.dart';
import 'API/screen/user_screen.dart';
import 'API/storage/shared_pref_controller.dart';
import 'DataBase/bloc/states/CRUD_States.dart';
import 'Screen/App/Note_Screen.dart';
import 'Screen/App/Notes_Screen.dart';
import 'Screen/Login_Screen.dart';
import 'Screen/Lunch_Screen.dart';
import 'Screen/Register_Screen.dart';

//import 'package:provider/provider.dart';
//import 'DataBase/Providers/note_provider.dart';
//import 'DataBase/Providers/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await PrefController().initPrefController();
  await SharedPrefController().initSharedPref();
  await DBController().initDataBase();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteBloc>(create: (context) => NoteBloc(LoadingState())),
      ],
      child: MaterialApp(
        initialRoute: '/LunchApiScreen',
        routes: {
          '/LunchScreen': (context) => const LunchScreen(),
          '/LoginScreen': (context) => const LoginScreen(),
          '/RegisterScreen': (context) => const RegisterScreen(),
          '/NotesScreen': (context) => const NotesScreen(),
          '/NoteScreen': (context) => const NoteScreen(),
          //////////////////////////////////////////////
          /** API Screen **/
          '/LunchApiScreen': (context) => const LunchApiScreen(),
          '/LoginApiScreen': (context) => const LoginApiScreen(),
          '/RegisterApiScreen': (context) => const RegisterApiScreen(),
          '/ForgetPasswordApiScreen': (context) =>
              const ForgetPasswordApiScreen(),
          '/UserScreen': (context) => const UserScreen(),
        },
      ),
    );
  }
}
/***


    //////////////////////////////////////////////////
    /*** Class MyApp to State Management Provider ***/
    //////////////////////////////////////////////////


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
 ***/
