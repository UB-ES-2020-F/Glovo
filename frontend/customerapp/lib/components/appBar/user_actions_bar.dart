import 'dart:html';

import 'package:customerapp/components/text_link.dart';
import 'package:customerapp/screens/location/location_dialog.dart';
import 'package:customerapp/screens/loggedPage/profile_settings.dart';
import 'package:customerapp/styles/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:customerapp/models/logged.dart';
import 'package:customerapp/styles/initial_logged.dart';
import 'package:provider/provider.dart';

enum BarType { initial, defaultBar }

class UserActions extends StatelessWidget {
  BarType barType;
  String optional;
  int type;

  UserActions(this.barType, this.type);

  @override
  Widget build(BuildContext context) {
    var loggedModel = context.watch<LoggedModel>();
    return Row(
      children: [
        IconButton(
          alignment: Alignment.topRight,
          iconSize: 22.0,
          color: _selectLocationIconColor(barType),
          icon: Icon(Icons.location_on_outlined),
          onPressed: () {
            if (MediaQuery.of(context).size.width > 900) {
              showDialog(context: context, builder: (_) => LocationDialog());
            } else {
              Navigator.pushNamed(context, '/location');
            }
          },
        ),
        IntrinsicWidth(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getFormattedDirection(loggedModel, type),
              style: _selectStreetNameTextLinksStyle(barType),
            ),
            Text(getFormattedInd(loggedModel, type),
                style: _selectIndicationsTextLinksStyle(barType)),
          ],
        )),
        IconButton(
          key: Key('profile-button'),
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

String getFormattedDirection(LoggedModel loggedModel, int type) {
  String direction;
  if (type == 1) {
    if (loggedModel.getUser().direction.length > 30) {
      direction = loggedModel.getUser().direction.substring(0, 30) + "...";
    } else {
      direction = loggedModel.getUser().direction;
    }
  } else {
    if (loggedModel.getUser().direction.length > 15) {
      direction = loggedModel.getUser().direction.substring(0, 15) + "...";
    } else {
      direction = loggedModel.getUser().direction;
    }
  }
  return direction;
}

String getFormattedInd(LoggedModel loggedModel, int type) {
  String ind;
  if (type == 1) {
    if (loggedModel.getUser().directionIndications.length > 30) {
      ind = loggedModel.getUser().directionIndications.substring(0, 30) + "...";
    } else {
      ind = loggedModel.getUser().directionIndications;
    }
  } else {
    if (loggedModel.getUser().directionIndications.length > 15) {
      ind = loggedModel.getUser().directionIndications.substring(0, 15) + "...";
    } else {
      ind = loggedModel.getUser().directionIndications;
    }
  }
  return ind;
}

class UserActionsBar extends StatelessWidget {
  BarType barType;
  String optional;

  UserActionsBar(this.barType) {}

  @override
  Widget build(BuildContext context) {
    var loggedModel = context.watch<LoggedModel>();
    return UserActions(barType, 1);
  }
}

class UserActionsBar_aux extends StatelessWidget {
  BarType barType;
  String optional;

  UserActionsBar_aux(this.barType) {}

  @override
  Widget build(BuildContext context) {
    var loggedModel = context.watch<LoggedModel>();
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
