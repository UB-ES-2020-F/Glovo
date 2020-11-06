import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final PriceTextStyleProduct = TextStyle(
    fontWeight: FontWeight.normal, color: Color(0xFF4a4a4a), fontSize: 20);
final DescriptionTextStyleProduct =
    TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 15);

final TitleStyleProduct =
    TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 22);

final RestaurantTitleStyle =
    TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 48);

final CartTitleStyle =
    TextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 28);

final CartTimeFeeStyle = TextStyle(color: Colors.black, fontSize: 16);

final makeOrderButtonStyle = ButtonStyle(
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
