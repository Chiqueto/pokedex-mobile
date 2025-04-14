//Firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

//Material UI
import 'package:flutter/material.dart';

//Páginas internas
import 'package:pokedex/firebase_options.dart';
import 'package:pokedex/pages/login_page.dart';
import 'package:pokedex/pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCiChfG9-FdZLj7Snixe18xr54_jWKi2LI",
          authDomain: "pokedex-app-50a65.firebaseapp.com",
          projectId: "pokedex-app-50a65",
          storageBucket: "pokedex-app-50a65.firebasestorage.app",
          messagingSenderId: "536470323024",
          appId: "1:536470323024:web:f84d5400f55e89d5c2f655"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage());
  }
}
