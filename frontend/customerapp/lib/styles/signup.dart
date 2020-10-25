import 'package:flutter/material.dart';

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
);

final signUpTextLinksBold = TextStyle(
  fontWeight: FontWeight.bold,
  color: Color(0xFF2ABB9B),
);

final signUpTextLinksHover = TextStyle(
  color: Color(0xFF104A3E),
);

final signUpTextLinksHoverBold = TextStyle(
  fontWeight: FontWeight.bold,
  color: Color(0xFF104A3E),
);
