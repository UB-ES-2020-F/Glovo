import 'package:flutter/material.dart';

final searchBarTextLinks = TextStyle(
  fontSize: 13,
  color: Colors.white,
);

final searchBarTextLinksHover = TextStyle(
  fontSize: 13,
  color: hoverIconColor,
);

final streetNameTextLinks = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

final streetNameTextLinksHover = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: hoverIconColor,
);

final indicationsTextLinks = TextStyle(
  fontSize: 12,
  color: Colors.white,
);

final indicationsTextLinksHover = TextStyle(
  fontSize: 12,
  color: hoverIconColor,
);

final hoverIconColor = Color(0xFFFFF3DA);

final labelsProfileTitleText = TextStyle(
  fontSize: 36,
  fontWeight: FontWeight.w600,
  color: Color(0x52000000),
);

final labelsProfileText = TextStyle(
  fontSize: 14,
  color: Color(0x66000000),
);

final fieldsProfileText = TextStyle(
  fontSize: 14,
  color: Color(0xFF606266),
);

final editTextLinksBold = TextStyle(
  fontWeight: FontWeight.bold,
  color: Color(0xFF2ABB9B),
);

final editTextLinksHoverBold = TextStyle(
  fontWeight: FontWeight.bold,
  color: Color(0xFF104A3E),
);

final editTextLinksBoldInactive = TextStyle(
  fontWeight: FontWeight.bold,
  color: Color(0xFF777777),
);

final locationInitialColor = Colors.white;

Color locationInitialColorIsHovered(bool isHovered) {
  if (!isHovered)
    return locationInitialColor;
  else
    return hoverIconColor;
}

final buttonMainColor = Colors.white;

final bigTextStyle =
    TextStyle(fontSize: 60, color: Colors.white, fontWeight: FontWeight.w700);

final mediumTextStyle =
    TextStyle(fontSize: 36, color: Colors.black, fontWeight: FontWeight.w700);

final mediumSmallTextStyle = TextStyle(
    fontSize: 18, color: Color(0xFF9B9B9B), fontWeight: FontWeight.w200);
