import 'package:customerapp/responsive/screen_responsive.dart';
import 'package:customerapp/screens/commonComponents/food_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:customerapp/screens/loggedPage/logged_bar.dart';

class InitialLogged extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget bar;

    var s = Bar_responsive(context, '/overview_mobile', InitialLoggedBar(),
        medium_bar: InitialLoggedBar_short());
    bar = s.get_responsive_bar();

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: bar,
        body: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Center(
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
        ));
  }
}
