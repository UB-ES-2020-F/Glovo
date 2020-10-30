import 'package:customerapp/styles/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FoodButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: RaisedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/restaurant-list');
          },
          color: Colors.white,
          textColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image(
                image: AssetImage('resources/images/food_logo.png'),
                height: 50,
                width: 50,
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  'Food',
                  style: categoryButtonLabel,
                ),
              )
            ],
          ),
          padding: EdgeInsets.all(30),
          shape: CircleBorder(),
        ));
  }
}
