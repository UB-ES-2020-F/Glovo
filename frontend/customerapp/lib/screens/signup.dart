import 'package:customerapp/components/text_link.dart';
import 'package:customerapp/models/signup.dart';
import 'package:customerapp/styles/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {},
          )
        ],
      ),
      body: Center(
        child: Container(
            child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            Center(
                child: Container(
              child: Text(
                'Register to Glovo',
                style: Theme.of(context).textTheme.headline2,
              ),
            )),
            Center(
                child: Container(
              child: SignUpForm(),
            )),
            Center(
              child: Container(
                child: Wrap(
                  children: [
                    Container(
                        child: Text('Have an account? ',
                            style: Theme.of(context).textTheme.bodyText1)),
                    TextLink(
                        'Login', () {}, signUpTextLinks, signUpTextLinksHover),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                child: Wrap(
                  children: [
                    Expanded(
                      child: Container(
                          child: Text('By registering, you agree to our ',
                              style: Theme.of(context).textTheme.bodyText1)),
                    ),
                    TextLink('Terms of Service', () {}, signUpTextLinks,
                        signUpTextLinksHover),
                    Container(
                        child: Text(' and ',
                            style: Theme.of(context).textTheme.bodyText1)),
                    TextLink('Privacy Policy', () {}, signUpTextLinks,
                        signUpTextLinksHover),
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var signUpModel = context.watch<SignUpModel>();
    return Form(
      key: signUpModel.formKey,
      child: Column(
        children: [
          Container(
              child: TextFormField(
            decoration: const InputDecoration(
                icon: Icon(Icons.perm_identity), hintText: 'First name'),
          )),
          Container(
              child: TextFormField(
            validator: (email) =>
                EmailValidator.validate(email) ? null : "Invalid email address",
            decoration: const InputDecoration(
                icon: Icon(Icons.mail_outline_outlined), hintText: 'Email'),
          )),
          Container(
              child: TextFormField(
            obscureText: signUpModel.passwordObfuscated,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: signUpModel.switchPasswordObfuscation,
                    icon: signUpModel.passwordObfuscated
                        ? Icon(Icons.visibility_off_outlined)
                        : Icon(Icons.visibility)),
                icon: Icon(Icons.lock_outlined),
                hintText: 'Password'),
          )),
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
    var signUpModel = context.watch<SignUpModel>();
    return Container(
      padding: EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              if (signUpModel.formKey.currentState.validate()) {
                Fluttertoast.showToast(
                    msg: "This is Center Short Toast",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
            child: Text('Sign up with email'),
            style: signUpButtonStyle,
          )
        ],
      ),
    );
  }
}
