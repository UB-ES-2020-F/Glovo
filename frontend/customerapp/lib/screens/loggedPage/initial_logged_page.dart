import 'package:customerapp/models/logged.dart';
import 'package:customerapp/models/user.dart';
import 'package:customerapp/screens/commonComponents/food_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:customerapp/screens/loggedPage/logged_bar.dart';

class InitialLogged extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var initialLoggedModel = new LoggedModel();
    User user = LoggedModel.user;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: InitialLoggedBar(),
      body: Center(
          child: Container(
              child: Center(
                  child: Column(
        children: [
          Text(
            'Komet ',
            style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor),
          ),
          FoodButton()
        ],
      )))),
    );
  }
}
