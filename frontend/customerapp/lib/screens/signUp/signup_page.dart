import 'package:customerapp/screens/signUp/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 600) {
      Navigator.pop(context);
    } else {
      print("2");
    }

    return Scaffold(
      body: ListView(children: [
        Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment(1, 1),
            child: IconButton(
              color: Color(0xFF6E6E6E),
              icon: Icon(Icons.clear),
              iconSize: 40,
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        Container(padding: EdgeInsets.all(30), child: SignUpFormPage())
      ]),
    );
  }
}
