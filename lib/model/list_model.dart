import 'package:flutter/material.dart';
import 'package:mindspace/style/app_style.dart';
import 'dart:math';

//temporary list of notes to implement until databse functionality is added

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
        color: AppStyle.cardColors[Random().nextInt(7)]),
    NoteContent(
        title: 'Feeling Stressed',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        color: AppStyle.cardColors[Random().nextInt(7)]),
    NoteContent(
        title: 'Started my new job',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        color: AppStyle.cardColors[Random().nextInt(7)]),
  ];
}
