import 'package:customerapp/screens/signIn/signin_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignInDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Wrap(children: [
        Container(
          constraints: BoxConstraints(maxWidth: 600),
          child: Column(children: [
            Container(
                constraints: BoxConstraints(maxWidth: 600),
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
            Container(
                padding: EdgeInsets.symmetric(horizontal: 70),
                child: SignInFormPage())
          ]),
        )
      ]),
    );
  }
}
