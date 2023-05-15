import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/list_model.dart';
import '../screens/journal.dart';
import '../style/app_style.dart';



class NoteListData extends StatefulWidget {
  const NoteListData({
    super.key,
  });

  @override
  State<NoteListData> createState() => _NoteListDataState();


}

class _NoteListDataState extends State<NoteListData> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ListView(
        children: [
          Text(
            'Your Entries',
            style: GoogleFonts.poppins(
              color: AppStyle.mainColor,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: NoteList.noteContent.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0),
              itemBuilder: (context, index) => NoteCard(
                noteCard: NoteList.noteContent[index],
                press: () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}
