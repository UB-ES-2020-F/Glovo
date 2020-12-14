import 'package:customerapp/styles/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FoodButton extends StatelessWidget {
  FoodButton(Key key) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        width: 160,
        height: 160,
        child: SizedBox.expand(
            child: RaisedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/restaurant-list');
          },
          onLongPress: null,
          color: Colors.white,
          disabledColor: Colors.white,
          textColor: Colors.white,
          elevation: 4,
          disabledElevation: 4,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('resources/images/food_logo.png'),
                height: 55,
                width: 55,
              ),
              Container(
                  padding: EdgeInsets.only(top: 5),
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Food',
                        style: categoryButtonLabel,
                        textAlign: TextAlign.center,
                      ))),
            ],
          ),
          padding: EdgeInsets.all(30),
          shape: CircleBorder(),
        )));
  }
}
