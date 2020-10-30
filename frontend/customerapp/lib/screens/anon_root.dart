import 'package:customerapp/screens/signUp/signup_dialog.dart';
import 'package:customerapp/screens/signIn/signin_dialog.dart';
import 'package:customerapp/styles/main_page.dart';
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
      body: Container(
          decoration: BoxDecoration(color: Color(0xFFffc244)),
          child: FoodButton()), //To delete
    );
  }
}

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

class LogInButton extends StatelessWidget {
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
