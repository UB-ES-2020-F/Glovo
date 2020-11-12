import 'package:customerapp/responsive/screen_responsive.dart';
import 'package:customerapp/screens/signUp/signup_dialog.dart';
import 'package:customerapp/screens/signIn/signin_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:customerapp/styles/signup.dart';
import 'package:customerapp/screens/anon_bar.dart';

class AnonRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget bar;

    var s = Bar_responsive(context, '/sign-up', AnonBar());
    bar = s.get_responsive_bar();

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: bar,
        body: Padding(
          padding: EdgeInsets.only(top: 20),
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
              //FoodButton() <-- TODO Add when prepared to handle session
            ],
          )))),
        ));
  }
}

class LogInButton extends StatelessWidget {
  LogInButton() : super(key: Key('login-button'));
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
        child: Text('Login'),
        style: loginButtonStyle);
  }

  void _showDialog(context) {
    showDialog(context: context, builder: (_) => SignInDialog());
  }

  void _showPage(context) {
    Navigator.pushNamed(context, '/sign-in');
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
