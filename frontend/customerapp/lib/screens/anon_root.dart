import 'package:customerapp/screens/signUp/signup_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:customerapp/styles/signup.dart';

class AnonRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(90.0), // here the desired height
          child: AppBar(
            actions: [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 9),
                  child: SignUpButton()),
              Padding(
                  padding: EdgeInsets.only(top: 9, bottom: 9, left: 10),
                  child: LogInButton())
            ],
          )),
      body: Text('Prueba'),
    );
  }
}

class LogInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {}, child: Text('Login'), style: loginButtonStyle);
  }
}

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: MediaQuery.of(context).size.width > 600
            ? () {
                _showDialog(context);
              }
            : () {
                _showPage(context);
              },
        child: Text('Register'),
        style: registerButtonStyle);
  }

  void _showDialog(context) {
    showDialog(context: context, builder: (_) => SignUpDialog());
  }

  void _showPage(context) {
    Navigator.pushNamed(context, '/sign-up');
  }
}
