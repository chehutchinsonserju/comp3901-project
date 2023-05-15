import 'dart:math';
import 'package:dialogflow_grpc/dialogflow_grpc.dart';
import 'package:dialogflow_grpc/generated/google/cloud/dialogflow/v2beta1/session.pb.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:capstone/model/list_model.dart';
import 'package:capstone/screens/journal.dart';
import 'package:capstone/style/app_style.dart';

late DialogflowGrpcV2Beta1 dialogflow;

class AddEntry extends StatefulWidget {
  const AddEntry({super.key});

  @override
  State<AddEntry> createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
  late String entryTitle;
  late String entryBody;
  User? _user;

  @override
  void initState() {
    super.initState();
    initPlugin();
  }

  Future<void> initPlugin() async {

    // TODO Get a Service account
    // Get a Service account
    final serviceAccount = ServiceAccount.fromString(
        '${(await rootBundle.loadString('assets/credentials.json'))}');
    // Create a DialogflowGrpc Instance
    dialogflow = DialogflowGrpcV2Beta1.viaServiceAccount(serviceAccount);

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.backgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        title: Text('New Journal Entry'),
        centerTitle: true,
        backgroundColor: AppStyle.mainColor,
        actionsIconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
          child: Column(
        children: [
          TextField(
            onChanged: (value) => entryTitle = value,
            style: AppStyle.mainTitle,
            decoration: const InputDecoration(
                hintText: 'Enter title',
                hintStyle: TextStyle(
                  color: Colors.black54,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            onChanged: (value) => entryBody = value,
            style: AppStyle.mainContent,
            decoration: const InputDecoration(
                hintText: 'Type your thoughts...',
                hintStyle: TextStyle(
                  color: Colors.black54,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                )),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var newEntry = NoteContent(
              title: entryTitle,
              description: entryBody,
              color: AppStyle.cardColors[Random().nextInt(7)]);

          DetectIntentResponse titledata = await dialogflow.detectIntent(newEntry.title, 'en-US');
          DetectIntentResponse descriptiondata = await dialogflow.detectIntent(newEntry.description, 'en-US');

          print(newEntry.title);
          print(newEntry.description);

          _user = FirebaseAuth.instance.currentUser;
          CollectionReference collRef = FirebaseFirestore.instance.collection('journal');
          collRef.add({
            'client_id': _user?.uid,
            'journalTitle': titledata.queryResult.queryText,
            'journalDescription': descriptiondata.queryResult.queryText,
            'sentimentscore':(titledata.queryResult.sentimentAnalysisResult.queryTextSentiment.score + descriptiondata.queryResult.sentimentAnalysisResult.queryTextSentiment.score)/2,

          });

          NoteList.noteContent.add(newEntry);

          Navigator.pop(context);
        },
        backgroundColor: AppStyle.accentColor,
        child: const Icon(Icons.send),
      ),
    );
  }
}
