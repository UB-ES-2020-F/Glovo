import 'package:customerapp/components/text_link.dart';
import 'package:customerapp/models/signin.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:customerapp/styles/signup.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SignInFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            child: ListView(shrinkWrap: true, children: [
      Center(
          child: Container(
        child: Text(
          'Login to Glovo',
          style: registerToGlovoTextStyle,
        ),
      )),
      SignInForm(),
      Align(
          child: Container(
              margin: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "New to Glovo? ",
                    style: TextStyle(color: Color(0xFF9B9B9B)),
                  ),
                  TextLink('Sign up', (context) {
                    Navigator.pushNamed(context, '/sign-up');
                  },
                      signUpTextLinks.copyWith(
                          fontSize: 13, fontWeight: FontWeight.bold),
                      signUpTextLinksHover.copyWith(
                          fontSize: 13, fontWeight: FontWeight.bold),
                      context)
                ],
              )),
          alignment: Alignment.bottomRight)
    ])));
  }
}

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var signInModel = context.watch<SignInModel>();
    return Form(
      onChanged: () =>
          signInModel.formValid = signInModel.formKey.currentState.validate(),
      key: signInModel.formKey,
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              constraints: BoxConstraints(maxWidth: 600),
              child: TextFormField(
                onSaved: (value) => signInModel.email = value,
                validator: (email) {
                  bool validEmail = EmailValidator.validate(email);
                  return validEmail ? null : "Invalid email address";
                },
                decoration: InputDecoration(
                  border: signUpInputTextBorder,
                  focusedBorder: signUpFocusedInputTextBorder,
                  icon: Icon(
                    Icons.mail_outline_outlined,
                    color: Color(0xFF9B9B9B),
                    size: 40,
                  ),
                  labelText: 'E-mail',
                  labelStyle: labelTextInputStyle,
                ),
              )),
          Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              constraints: BoxConstraints(maxWidth: 600),
              child: TextFormField(
                onSaved: (value) => signInModel.password = value,
                obscureText: signInModel.passwordObfuscated,
                validator: (password) {
                  bool passwordValid = password.isNotEmpty;
                  return passwordValid ? null : "Password is required";
                },
                decoration: InputDecoration(
                  border: signUpInputTextBorder,
                  focusedBorder: signUpFocusedInputTextBorder,
                  suffixIcon: IconButton(
                      onPressed: signInModel.switchPasswordObfuscation,
                      icon: signInModel.passwordObfuscated
                          ? Icon(
                              Icons.visibility_off_outlined,
                              color: Color(0xFF9B9B9B),
                            )
                          : Icon(
                              Icons.visibility,
                              color: Color(0xFF9B9B9B),
                            )),
                  icon: Icon(
                    Icons.lock_outlined,
                    color: Color(0xFF9B9B9B),
                    size: 40,
                  ),
                  labelText: 'Password',
                  labelStyle: labelTextInputStyle,
                ),
              )),
          Align(
            child: Container(
                margin: EdgeInsets.all(20.0),
                alignment: Alignment.centerRight,
                child: TextLink('Forgot your password?', (context) {
                  Navigator.pushNamed(context, '/sign-in');
                },
                    signUpTextLinks.copyWith(
                        fontSize: 13, fontWeight: FontWeight.bold),
                    signUpTextLinksHover.copyWith(
                        fontSize: 13, fontWeight: FontWeight.bold),
                    context)),
            alignment: Alignment.bottomCenter,
          ),
          SignUpButton(),
        ],
      ),
    );
  }
}

/*
  It may be better to pass only formKey as parameter (or the model)
*/
class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var signUpModel = context.watch<SignInModel>();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Wrap(
        children: [
          ElevatedButton(
            onPressed: signUpModel.formValid
                ? () {
                    if (signUpModel.formKey.currentState.validate()) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/initial-logged-in', (route) => false);
                    }
                  }
                : null,
            child: Text('Log in with email'),
            style: signUpModel.formValid
                ? signUpButtonStyleEnabled
                : signUpButtonStyleDisabled,
          )
        ],
      ),
    );
  }
}
