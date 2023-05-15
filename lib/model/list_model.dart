import 'package:flutter/material.dart';
import 'package:capstone/style/app_style.dart';
import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//temporary list of notes to implement until databse functionality is added

User? _user;

class NoteContent {
  final String title, description;
  final Color color;

  NoteContent({
    required this.title,
    required this.description,
    required this.color,
  });
}

class NoteList {


  static List<NoteContent> noteContent = [
    NoteContent(
        title: 'Made A New Friend',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        color: AppStyle.cardColors[Random().nextInt(7)]),
    NoteContent(
        title: 'Had a tough day',
        description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        color: AppStyle.cardColors[Random().nextInt(7)])
  ];
  static void addFromFirestore(QuerySnapshot<Map<String, dynamic>> snapshot) {
    _user = FirebaseAuth.instance.currentUser;
    for (var doc in snapshot.docs) {
      var data = doc.data();
      if(data['client_id']==_user?.uid){
        var item = NoteContent(title: data['journalTitle'], description: data['journalDescription'], color: AppStyle.cardColors[Random().nextInt(7)]);
        noteContent.add(item);
      }

    }
  }



}
