import 'package:customerapp/components/text_link.dart';
import 'package:customerapp/screens/signIn/signin_form.dart';
import 'package:customerapp/styles/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ForgotPasswordSuccessDialog extends StatelessWidget {
  String email;
  ForgotPasswordSuccessDialog(this.email);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Wrap(children: [
        Container(
          constraints: BoxConstraints(maxWidth: 600),
          child: Column(children: [
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
            Container(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 70),
                child: ForgotPasswordSuccess(email))
          ]),
        )
      ]),
    );
  }
}

class ForgotPasswordSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context).settings.arguments;
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
        Container(
            padding: EdgeInsets.all(30), child: ForgotPasswordSuccess(email))
      ]),
    );
  }
}

class ForgotPasswordSuccess extends StatelessWidget {
  String email;
  ForgotPasswordSuccess(this.email);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height - 150),
            child: ListView(shrinkWrap: true, children: [
              Center(
                  child: Column(children: [
                Text(
                  'Email sent!',
                  style: registerToKometTextStyle,
                ),
                Container(
                  height: 15,
                ),
                Text(
                  'Check your',
                  style: signUpText,
                  textAlign: TextAlign.center,
                ),
                Text(
                  ' $email ',
                  style: signUpText.copyWith(fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'inbox for instructions from us on how to reset your password. You may need to check your spam folder.',
                  style: signUpText,
                  textAlign: TextAlign.center,
                ),
                AcceptEmailSentButton(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Text(
                        "Didn’t receive instructions? ",
                        style: signUpText,
                      ),
                      TextLink('Try Again', (context) {
                        Navigator.pop(context);
                        showForgotPassword(context);
                      }, signUpTextLinks, signUpTextLinksHover, context),
                    ])
              ])),
            ])));
  }
}

class AcceptEmailSentButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Wrap(
        children: [
          ElevatedButton(
              onLongPress: null,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
              style: signUpButtonStyleEnabled)
        ],
      ),
    );
  }
}
