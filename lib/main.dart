import 'package:flutter/material.dart';
import 'package:capstone/screens/journal.dart';
import 'package:capstone/screens/login.dart';
import 'package:capstone/screens/chat.dart';
import 'package:capstone/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:capstone/model/list_model.dart';

Future<void> main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
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
    var snapshot = await FirebaseFirestore.instance.collection('journal').get();
    NoteList.addFromFirestore(snapshot);

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