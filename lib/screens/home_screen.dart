// ignore_for_file: prefer_const_constructors
import 'package:google_sign_in/google_sign_in.dart';
import 'package:capstone/components/bottom_navigation_bar.dart';
import 'package:capstone/screens/journal.dart';
import 'package:capstone/screens/chat.dart';
import 'package:capstone/screens/login.dart';
import 'package:capstone/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../components/chart.dart';
import '../components/image_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  void _handleSignOut() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      await _googleSignIn.signOut();
      _googleSignIn = GoogleSignIn();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );

    } catch (error) {
      print(error);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.backgroundColor,
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: 1,
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JournalScreen()),
              );
              break;
            case 1:
              Navigator.pushNamed(
                context,
                '/home',
              );
              break;
            case 2:
              Navigator.pushNamed(
                context,
                '/chat',
              );
              break;
          }
        },
      ),
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        backgroundColor: Colors.grey,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async{

              _handleSignOut();// Add logout functionality here
            },
          ),
        ],
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Image.asset(
            'assets/images/logo.png',
            width: 50,
            height: 50,
          ),
          SizedBox(width: 10),
          Text(
            "Welcome to MindSpace!",
            style: TextStyle(
                color: AppStyle.mainColor,
                fontSize: AppStyle.mainTitle.fontSize,
                fontWeight: AppStyle.mainTitle.fontWeight,
                fontFamily: AppStyle.mainTitle.fontFamily),
          )
        ],
      ),
    ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Quick Start",
              style: TextStyle(
                  color: AppStyle.accentColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: HorizontalListWithImage(
                options: ['journal', 'anxiety', 'happiness', 'anger', 'stress'],
                onOptionSelected: (option) {
                  switch (option) {
                    case 'journal':
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => JournalScreen()),
                      );
                      break;
                    case 'anxiety':
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatScreen(message: 'I am feeling anxious right now')),
                      );
                      break;
                    case 'happiness':
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatScreen(message: 'I am feeling happy right now')),
                      );
                      break;
                    case 'anger':
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatScreen(message: 'I am feeling angry right now')),
                      );
                      break;
                    case 'stress':
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatScreen(message: 'I am feeling stressed right now')),
                      );
                      break;
                    default:
                      print('Unknown option selected');
                  }
                },
              ),
            ),
          ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "Here’s How I’ve Noticed Your Mood has Been",
                style: TextStyle(
                    color: AppStyle.accentColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: 30),
            Expanded(child: Center(child: MoodChart())),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/chat',
                      );
                    },
                    child: Text('Start a chat session...'),
                    style: TextButton.styleFrom(
                        backgroundColor: AppStyle.accentColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: 60.0, vertical: 25.0),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(30.0))))),
              ),
            ),
            /* Center(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/chat',
                  );
                },
                child: Text('Emergency Contacts'),
                style: TextButton.styleFrom(
                    backgroundColor: AppStyle.accentColor,
                    foregroundColor: Colors.white,
                    padding:
                        EdgeInsets.symmetric(horizontal: 60.0, vertical: 25.0),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(30.0))))),
          ),
          SizedBox(height: 20.0), */
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/chat',
                    );
                  },
                  child: Text('SOS'),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding:
                      EdgeInsets.symmetric(horizontal: 110.0, vertical: 25.0),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(30.0))))),
            ),
            SizedBox(height: 20.0),
          ],
      ),
    );
  }
}