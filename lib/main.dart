// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:capstone/screens/journal.dart';
import 'package:capstone/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/chat.dart';
import 'screens/home_screen.dart';
//import 'firebase_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      home: HomeScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/journal': (context) => JournalScreen(),
        '/chat': (context) => ChatScreen()
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Firebase init
  Future<Scaffold> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return LoginScreen();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
