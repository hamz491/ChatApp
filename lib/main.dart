import 'package:chat_app/Cubits/Auth_Bloc/BlocObserver.dart';
import 'package:chat_app/Cubits/Auth_Bloc/auth_bloc.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/screens/Chat_Page.dart';
import 'package:chat_app/screens/Login.dart';
import 'package:chat_app/screens/Register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

bool? islogin;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    islogin = false;
  } else {
    islogin = true;
  }
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        routes: {
          login.id: (context) => login(),
          Register.id: (context) => Register(),
          Chatpage.id: (context) => Chatpage(),
        },
        home: islogin == true ? Chatpage() : login(),
      ),
    );
  }
}
