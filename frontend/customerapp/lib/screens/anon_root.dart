import 'dart:ui';

import 'package:customerapp/components/footer.dart';
import 'package:customerapp/responsive/screen_responsive.dart';
import 'package:customerapp/screens/signUp/signup_dialog.dart';
import 'package:customerapp/screens/signIn/signin_dialog.dart';
import 'package:customerapp/styles/footer.dart';
import 'package:flutter/foundation.dart';
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
                      child: SingleChildScrollView(child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Komet ',
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).accentColor),
              ),
              Text(
                'Komet ',
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).accentColor),
              ),
              Text(
                'Komet ',
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).accentColor),
              ),
              Text(
                'Komet ',
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).accentColor),
              ),
              Text(
                'Komet ',
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).accentColor),
              ),

              //Container(height: 400,child:
              //SampleAnimation(MediaQuery.of(context).size.width)),
              Footer()
              ]
              ))),
        ))));
  }
}


class LogInButton extends StatelessWidget {
  LogInButton() : super(key: Key('login-button'));
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 120,
        height: 43,
        child: SizedBox.expand(
          child: ElevatedButton(
              onPressed: () {
                showSignIn(context);
              },
              child: Text('Login'),
              style: loginButtonStyle),
        ));
  }
}

void showSignIn(BuildContext context) {
  if (MediaQuery.of(context).size.width > 600) {
    showDialog(context: context, builder: (_) => SignInDialog());
  } else {
    Navigator.pushNamed(context, '/sign-in');
  }
}

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 120,
        height: 43,
        child: SizedBox.expand(
          child: ElevatedButton(
              onPressed: () {
                showSignUp(context);
              },
              child: Text('Register'),
              style: registerButtonStyle),
        ));
  }
}



void showSignUp(BuildContext context) {
  
  if (MediaQuery.of(context).size.width > 600) {
    showDialog(context: context, builder: (_) => SignUpDialog());
  } else {
    Navigator.pushNamed(context, '/sign-up');
  }
}

