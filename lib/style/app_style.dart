import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static Color backgroundColor = Color.fromARGB(255, 255, 255, 255);
  static Color mainColor = Color.fromARGB(225, 29, 154, 173);
  static Color accentColor = Color.fromARGB(225, 24, 128, 196);

  static List<Color> cardColors = [
    Colors.yellow.shade100,
    Colors.red.shade100,
    Colors.orange.shade100,
    Colors.green.shade100,
    Colors.blue.shade100,
    Colors.pink.shade100,
    Colors.blueGrey.shade100,
  ];

  static TextStyle mainTitle =
      GoogleFonts.poppins(fontSize: 24.0, fontWeight: FontWeight.bold);

  static TextStyle mainContentTitle =
      GoogleFonts.poppins(fontSize: 14.0, fontWeight: FontWeight.w600);

  static TextStyle mainContent =
      GoogleFonts.poppins(fontSize: 14.0, fontWeight: FontWeight.normal);

  static TextStyle dateTitle =
      GoogleFonts.poppins(fontSize: 10.0, fontWeight: FontWeight.w100);
}
