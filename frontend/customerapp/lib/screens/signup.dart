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
                    TextLink('Login', () {}, signUpTextLinksBold,
                        signUpTextLinksHoverBold),
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
      onChanged: () =>
          signUpModel.formValid = signUpModel.formKey.currentState.validate(),
      key: signUpModel.formKey,
      child: Column(
        children: [
          Container(
              child: TextFormField(
            onSaved: (value) => signUpModel.firstName = value,
            validator: (firstName) {
              bool validFirstName = firstName.isNotEmpty;
              return validFirstName ? null : "Name is required";
            },
            decoration: const InputDecoration(
                icon: Icon(Icons.perm_identity), labelText: 'First name'),
          )),
          Container(
              child: TextFormField(
            onSaved: (value) => signUpModel.email = value,
            validator: (email) {
              bool validEmail = EmailValidator.validate(email);
              return validEmail ? null : "Invalid email address";
            },
            decoration: const InputDecoration(
              icon: Icon(Icons.mail_outline_outlined),
              labelText: 'Email',
            ),
          )),
          Container(
              child: TextFormField(
            onSaved: (value) => signUpModel.password = value,
            obscureText: signUpModel.passwordObfuscated,
            validator: (password) {
              bool passwordValid = password.isNotEmpty;
              return passwordValid ? null : "Password is required";
            },
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: signUpModel.switchPasswordObfuscation,
                  icon: signUpModel.passwordObfuscated
                      ? Icon(Icons.visibility_off_outlined)
                      : Icon(Icons.visibility)),
              icon: Icon(Icons.lock_outlined),
              labelText: 'Password',
            ),
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
            onPressed: signUpModel.formValid
                ? () {
                    if (signUpModel.formKey.currentState.validate()) {
                      Fluttertoast.showToast(
                          msg: "Hola",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      signUpModel.formKey.currentState.save();
                    }
                  }
                : null,
            child: Text('Sign up with email'),
            style: signUpModel.formValid
                ? signUpButtonStyleEnabled
                : signUpButtonStyleDisabled,
          )
        ],
      ),
    );
  }
}
