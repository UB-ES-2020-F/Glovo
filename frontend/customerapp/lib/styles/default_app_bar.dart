import 'package:flutter/material.dart';

final locationDefaultColor = Color(0xFF2ABB9B);

final defaultColorHovered = Color(0xFF50D7B6);

Color locationDefaultColorIsHovered(bool isHovered) {
  if (!isHovered)
    return locationDefaultColor;
  else
    return defaultColorHovered;
}

final defaultStreetNameTextLinks = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: locationDefaultColor,
);

final defaultStreetNameTextLinksHover = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: defaultColorHovered,
);

final defaultIndicationsTextLinks = TextStyle(
  fontSize: 12,
  color: Color(0xFFFFC244),
);

final defaultIndicationsTextLinksHover = TextStyle(
  fontSize: 12,
  color: Color(0xFFFFD47C),
);

final defaultButtonMainColor = Color(0xFFCCCCCC);

final borderAppBar = Color(0xFFCCCCCC);

final defaultAppBarBackgroundColor = Color(0xFFFAFAFA);
