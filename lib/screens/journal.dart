import 'package:capstone/components/bottom_navigation_bar.dart';
import 'package:capstone/screens/chat.dart';
import 'package:flutter/material.dart';
import 'package:capstone/style/app_style.dart';
import 'package:capstone/model/list_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/note_list_data.dart';
import 'add_entry/add_entry.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {

  @override
  void initState() {
    super.initState();
    initPlugin();
  }
  Future<void> initPlugin() async {

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    var snapshot = await FirebaseFirestore.instance.collection('journal').get();
    NoteList.addFromFirestore(snapshot);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.backgroundColor,
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: 0,
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
        title: Text('Journal'),
        centerTitle: true,
        backgroundColor: AppStyle.mainColor,
      ),
      body: NoteListData(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddEntry()));
        },
        backgroundColor: AppStyle.accentColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.noteCard,
    required this.press,
  });
  final NoteContent noteCard;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: noteCard.color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Text(
              noteCard.title,
              style: AppStyle.mainContentTitle,
            ),
            Text(
              noteCard.description,
              maxLines: 3,
              style: AppStyle.mainContent,
            ),
          ],
        ),
      ),
    );
  }
}
