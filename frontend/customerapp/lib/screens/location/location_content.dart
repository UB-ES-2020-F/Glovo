import 'package:customerapp/models/location.dart';
import 'package:customerapp/models/logged.dart';
import 'package:customerapp/models/map_location.dart';
import 'package:customerapp/styles/location.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'map_screen.dart';

class LocationContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: (MediaQuery.of(context).size.width > 900)
            ? ScreenContent()
            : MobileContent());
  }
}

class ScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Choose a delivery address",
          style: locationTitleStyle,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [LocationForm(), MapScreen()],
        )
      ],
    );
  }
}

class MobileContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(
          "Choose a delivery address",
          style: locationTitleStyle,
        ),
        MapScreen(),
        LocationForm(),
      ],
    );
  }
}

class LocationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapLocationModel = context.watch<MapLocationModel>();
    return Form(
      child: Column(
        children: [
          Focus(
            onFocusChange: (hasFocus) {
              if (!hasFocus) {
                mapLocationModel.name =
                    mapLocationModel.locationTextController.text;
              }
            },
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                constraints: (MediaQuery.of(context).size.width > 900)
                    ? BoxConstraints(maxWidth: 300)
                    : BoxConstraints(maxWidth: 900),
                child: TextFormField(
                  controller: mapLocationModel.locationTextController,
                  decoration: InputDecoration(
                    border: locationInputTextBorder,
                    focusedBorder: locationFocusedInputTextBorder,
                    icon: Icon(
                      Icons.tour_outlined,
                      color: Color(0xFF9B9B9B),
                      size: 40,
                    ),
                    labelText: 'Delivery adress',
                    labelStyle: labelTextInputStyle,
                  ),
                  autofocus: true,
                  validator: (locationText) {
                    return mapLocationModel.formValid
                        ? null
                        : "The location can not be found";
                  },
                )),
          ),
          Visibility(
              visible: mapLocationModel.formValid,
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  constraints: (MediaQuery.of(context).size.width > 900)
                      ? BoxConstraints(maxWidth: 300)
                      : BoxConstraints(maxWidth: 900),
                  child: TextFormField(
                    controller: mapLocationModel.indicationsTextController,
                    decoration: InputDecoration(
                      border: locationInputTextBorder,
                      focusedBorder: locationFocusedInputTextBorder,
                      icon: Icon(
                        Icons.home_outlined,
                        color: Color(0xFF9B9B9B),
                        size: 40,
                      ),
                      labelText: 'Floor, door, instructions...',
                      labelStyle: labelTextInputStyle,
                    ),
                  ))),
          Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              constraints: (MediaQuery.of(context).size.width > 900)
                  ? BoxConstraints(maxWidth: 300)
                  : BoxConstraints(maxWidth: 900),
              child: SetLocationButton())
        ],
      ),
    );
  }
}

class SetLocationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapLocationModel = context.watch<MapLocationModel>();
    final loggedModel = context.watch<LoggedModel>();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Wrap(
        children: [
          ElevatedButton(
            onLongPress: null,
            onPressed: mapLocationModel.formValid
                ? () {
                    mapLocationModel.name =
                        mapLocationModel.locationTextController.text;
                    if (mapLocationModel.formValid) {
                      loggedModel.getUserAndNotify().direction =
                          mapLocationModel.name;
                      loggedModel.getUserAndNotify().location = Location(
                          mapLocationModel.currentCoordinates.latitude,
                          mapLocationModel.currentCoordinates.longitude);
                      loggedModel.getUserAndNotify().directionIndications =
                          mapLocationModel.indicationsTextController.text;
                    }
                    Navigator.pop(context);
                  }
                : null,
            child: Text('Set locaton'),
            style: mapLocationModel.formValid
                ? locationButtonStyleEnabled
                : locationButtonStyleDisabled,
          )
        ],
      ),
    );
  }
}
