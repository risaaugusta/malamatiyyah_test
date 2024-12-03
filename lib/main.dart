import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:r_muslim/screens/google_login_draft.dart';
import 'package:r_muslim/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyCeMmpU6EFQHdYlOPY7pkB2ugLuJQG6x3I',
          appId: '1:994500705848:android:df5ef79fcc52898adb30cd',
          messagingSenderId: '994500705848',
          projectId: 'malamatiyyah-4ef41'));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginScreen(),
      // home: GoogleSignInScreen(),
    );
  }
}
