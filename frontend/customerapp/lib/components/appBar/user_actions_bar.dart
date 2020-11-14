import 'dart:html';

import 'package:customerapp/components/text_link.dart';
import 'package:customerapp/screens/loggedPage/initial_logged_page.dart';
import 'package:customerapp/screens/loggedPage/profile_settings.dart';
import 'package:customerapp/styles/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:customerapp/models/logged.dart';
import 'package:customerapp/styles/initial_logged.dart';

enum BarType { initial, defaultBar }

class UserActions extends StatelessWidget {
  BarType barType;
  String optional;
  int type;

  UserActions(this.barType, this.type);

  @override
  Widget build(BuildContext context) {
    var initialLoggedModel = LoggedModel();
    String direction, ind;
    List<Widget> direction_w, direction_indication_w;

    if (type == 1) {
      if (LoggedModel.direction.length > 30) {
        direction = LoggedModel.direction.substring(0, 30) + "...";
      } else {
        direction = LoggedModel.direction;
      }

      if (LoggedModel.indicationsDirection.length > 30) {
        ind = LoggedModel.indicationsDirection.substring(0, 30) + "...";
      } else {
        ind = LoggedModel.indicationsDirection;
      }
    } else {
      if (LoggedModel.direction.length > 15) {
        direction = LoggedModel.direction.substring(0, 15) + "...";
      } else {
        direction = LoggedModel.direction;
      }

      if (LoggedModel.indicationsDirection.length > 15) {
        ind = LoggedModel.indicationsDirection.substring(0, 15) + "...";
      } else {
        ind = LoggedModel.indicationsDirection;
      }
    }

    return Row(
      children: [
        IconButton(
          alignment: Alignment.topRight,
          iconSize: 22.0,
          color: _selectLocationIconColor(barType),
          icon: Icon(Icons.location_on_outlined),
          onPressed: () {},
        ),
        IntrinsicWidth(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextLink(
                direction,
                (context) {},
                _selectStreetNameTextLinksStyle(barType),
                _selectStreetNameTextLinksHoverStyle(barType),
                context),
            TextLink(
                ind,
                (context) {},
                _selectIndicationsTextLinksStyle(barType),
                _selectIndicationsTextLinksHoverStyle(barType),
                context),
          ],
        )),
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

class UserActionsBar extends StatelessWidget {
  BarType barType;
  String optional;

  UserActionsBar(this.barType) {}

  @override
  Widget build(BuildContext context) {
    var initialLoggedModel = LoggedModel();

    return UserActions(barType, 1);
  }
}

class UserActionsBar_aux extends StatelessWidget {
  BarType barType;
  String optional;

  UserActionsBar_aux(this.barType) {}

  @override
  Widget build(BuildContext context) {
    var initialLoggedModel = LoggedModel();

    return UserActions(barType, 2);
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
