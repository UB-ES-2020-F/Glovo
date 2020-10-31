import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:customerapp/screens/loggedPage/logged_bar.dart';
import 'package:hover_effect/hover_effect.dart';

class Prueba extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Widgetss();
  }
}

class Widgetss extends State<StatefulWidget> {
  double elevationn = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
          elevation: this.elevationn,
          child: InkWell(
            onTap: () {},
            onHover: (value) {
              print(value);
              if (value) {
                setState(() {
                  elevationn = 5;
                });
              } else {
                setState(() {
                  elevationn = 0;
                });
              }
            },
            child: Container(
              margin: const EdgeInsets.all(10.0),
              color: Colors.amber[600],
              width: 48.0,
              height: 48.0,
            ),
          )),
    );
  }
}
