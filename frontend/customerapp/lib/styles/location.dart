import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final locationTitleStyle = GoogleFonts.raleway(
    color: Colors.black,
    fontSize: 21,
    fontWeight: FontWeight.w700,
    letterSpacing: 1);

final labelTextInputStyle = TextStyle(
  color: Color(0xFF69B9B9B),
);
final locationFocusedInputTextBorder = UnderlineInputBorder(
    borderSide: BorderSide(width: 2, color: Color(0xFF6E6E6E)));

final locationInputTextBorder =
    UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF9B9B9B)));

final locationButtonStyleEnabled = ButtonStyle(
    padding: MaterialStateProperty.resolveWith((states) =>
        const EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0)),
    foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
    textStyle: MaterialStateProperty.resolveWith((states) => TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
    shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
        side: BorderSide(color: Color(0xFF2ABB9B)))),
    backgroundColor:
        MaterialStateColor.resolveWith((states) => Color(0xFF2ABB9B)));

final locationButtonStyleDisabled = ButtonStyle(
    padding: MaterialStateProperty.resolveWith((states) =>
        const EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0)),
    foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
    textStyle: MaterialStateProperty.resolveWith((states) => TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
    shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
        side: BorderSide(color: Color(0xFFE4E4E4)))),
    backgroundColor:
        MaterialStateColor.resolveWith((states) => Color(0xFFE4E4E4)));