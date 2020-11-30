//import 'dart:html';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

final greenButtonStyle = ButtonStyle(
    padding: MaterialStateProperty.resolveWith((states) =>
        const EdgeInsets.symmetric(vertical: 23.0, horizontal: 30.0)),
    foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
    textStyle: MaterialStateProperty.resolveWith((states) => TextStyle(
        color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700)),
    shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: Color(0xFF2ABB9B)))),
    backgroundColor:
        MaterialStateColor.resolveWith((states) => Color(0xFF2ABB9B)));

final registerButtonStyle = ButtonStyle(
    padding: MaterialStateProperty.resolveWith((states) =>
        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 26.0)),
    foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
    textStyle: MaterialStateProperty.resolveWith((states) => TextStyle(
        color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700)),
    shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(21.5),
        side: BorderSide(color: Color(0xFF2ABB9B)))),
    backgroundColor:
        MaterialStateColor.resolveWith((states) => Color(0xFF2ABB9B)));

final loginButtonStyle = ButtonStyle(
    padding: MaterialStateProperty.resolveWith((states) =>
        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 26.0)),
    foregroundColor:
        MaterialStateColor.resolveWith((states) => Color(0xFF4A4A4A)),
    textStyle: MaterialStateProperty.resolveWith((states) => TextStyle(
        color: Color(0xFF4A4A4A), fontSize: 14, fontWeight: FontWeight.w700)),
    shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(21.5),
        side: BorderSide(color: Colors.white))),
    backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white));

final signUpButtonStyleEnabled = ButtonStyle(
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

final signUpButtonStyleDisabled = ButtonStyle(
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

final signUpTextLinks = TextStyle(
  color: Color(0xFF2ABB9B),
  fontSize: 14,
  fontWeight: FontWeight.w600,
);

final signUpText = TextStyle(
  fontWeight: FontWeight.w300,
  fontSize: 14,
  color: Color(0xFF4a4a4a),
);

final signUpTextLinksHover = TextStyle(
  color: Color(0xFF528A84),
  fontSize: 14,
  fontWeight: FontWeight.w600,
);

final signUpTextLinksHoverBold = TextStyle(
  fontWeight: FontWeight.bold,
  color: Color(0xFF528A84),
);

final registerToKometTextStyle = GoogleFonts.raleway(
    color: Colors.black,
    fontSize: 21,
    fontWeight: FontWeight.w700,
    letterSpacing: 1);

final signUpFocusedInputTextBorder = UnderlineInputBorder(
    borderSide: BorderSide(width: 2, color: Color(0xFF6E6E6E)));

final signUpInputTextBorder =
    UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF9B9B9B)));

final labelTextInputStyle = TextStyle(
  color: Color(0xFF69B9B9B),
);
