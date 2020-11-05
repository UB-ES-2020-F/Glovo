import 'package:customerapp/components/text_link.dart';
import 'package:customerapp/screens/loggedPage/profile_settings.dart';
import 'package:customerapp/styles/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:customerapp/models/logged.dart';
import 'package:customerapp/styles/initial_logged.dart';

enum BarType { initial, defaultBar }

// ignore: must_be_immutable
class UserActionsBar extends StatelessWidget {
  BarType barType;
  UserActionsBar(this.barType);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            IconButton(
              alignment: Alignment.topRight,
              iconSize: 22.0,
              color: _selectLocationIconColor(barType),
              icon: Icon(Icons.location_on_outlined),
              onPressed: () {},
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextLink(
                    LoggedModel.direction,
                    (context) {},
                    _selectStreetNameTextLinksStyle(barType),
                    _selectStreetNameTextLinksHoverStyle(barType),
                    context),
                TextLink(
                    LoggedModel.indicationsDirection,
                    (context) {},
                    _selectIndicationsTextLinksStyle(barType),
                    _selectIndicationsTextLinksHoverStyle(barType),
                    context)
              ],
            )
          ],
        ),
        IconButton(
          iconSize: 35.0,
          color: _selectMainButtonColor(barType),
          icon: Icon(Icons.account_circle_outlined),
          onPressed: () {
            _openProfileSettings(context);
          },
        ),
        IconButton(
          iconSize: 35.0,
          color: _selectMainButtonColor(barType),
          icon: Icon(Icons.format_list_bulleted_outlined),
          onPressed: () {},
        )
      ],
    );
  }
}

void _openProfileSettings(BuildContext context) {
  Navigator.of(context).push(
    PageRouteBuilder(
        pageBuilder: (context, _, __) => ProfileSettings(context),
        opaque: false,
        barrierDismissible: true,
        reverseTransitionDuration: Duration(milliseconds: 0)),
  );
}

// ignore: missing_return
Color _selectLocationIconColor(BarType barType) {
  switch (barType) {
    case BarType.initial:
      return locationInitialColor;
    case BarType.defaultBar:
      return locationDefaultColor;
  }
}

TextStyle _selectStreetNameTextLinksStyle(BarType barType) {
  switch (barType) {
    case BarType.initial:
      return streetNameTextLinks;
    case BarType.defaultBar:
      return defaultStreetNameTextLinks;
  }
}

TextStyle _selectStreetNameTextLinksHoverStyle(BarType barType) {
  switch (barType) {
    case BarType.initial:
      return streetNameTextLinksHover;
    case BarType.defaultBar:
      return defaultStreetNameTextLinksHover;
  }
}

TextStyle _selectIndicationsTextLinksStyle(BarType barType) {
  switch (barType) {
    case BarType.initial:
      return indicationsTextLinks;
    case BarType.defaultBar:
      return defaultIndicationsTextLinks;
  }
}

TextStyle _selectIndicationsTextLinksHoverStyle(BarType barType) {
  switch (barType) {
    case BarType.initial:
      return indicationsTextLinksHover;
    case BarType.defaultBar:
      return defaultIndicationsTextLinksHover;
  }
}

Color _selectMainButtonColor(BarType barType) {
  switch (barType) {
    case BarType.initial:
      return buttonMainColor;
    case BarType.defaultBar:
      return defaultButtonMainColor;
  }
}
