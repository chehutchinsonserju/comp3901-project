import 'dart:math';

import 'package:flutter/material.dart';
import 'package:capstone/model/list_model.dart';
import 'package:capstone/screens/journal.dart';
import 'package:capstone/style/app_style.dart';

class AddEntry extends StatefulWidget {
  const AddEntry({super.key});

  @override
  State<AddEntry> createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
  late String entryTitle;
  late String entryBody;

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
        onPressed: () {
          print('Entry Title: $entryTitle');
          print('Entry Body: $entryBody');

          var newEntry = NoteContent(
              title: entryTitle,
              description: entryBody,
              color: AppStyle.cardColors[Random().nextInt(7)]);

          print(newEntry.title);
          print(newEntry.description);

          NoteList.noteContent.add(newEntry);

          Navigator.pop(context);
        },
        backgroundColor: AppStyle.accentColor,
        child: const Icon(Icons.send),
      ),
    );
  }
}
