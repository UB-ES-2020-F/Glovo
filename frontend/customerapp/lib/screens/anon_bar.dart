import 'package:customerapp/components/appBar/searchBox.dart';
import 'package:customerapp/screens/signIn/signin_dialog.dart';
import 'package:customerapp/screens/signUp/signup_dialog.dart';
import 'package:customerapp/styles/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnonBar extends StatelessWidget with PreferredSizeWidget {
  final double appBarHeight = 115.0;

  @override
  get preferredSize => Size.fromHeight(appBarHeight);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Theme.of(context).backgroundColor,
              title: Padding(
                  padding: EdgeInsets.all(40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SearchBox(),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: SignUpButton(),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: LogInButton(),
                          ),
                        ],
                      )
                    ],
                  )))
        ],
      ),
      color: Theme.of(context).backgroundColor,
    );
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
