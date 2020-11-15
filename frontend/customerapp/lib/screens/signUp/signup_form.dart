import 'package:customerapp/components/text_link.dart';
import 'package:customerapp/dto/user.dart';
import 'package:customerapp/models/signup.dart';
import 'package:customerapp/screens/anon_root.dart';
import 'package:customerapp/styles/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:customerapp/endpoints/login_register.dart';

class SignUpFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          child: ListView(
        shrinkWrap: true,
        children: [
          Center(
              child: Container(
            child: Text(
              'Register to Komet',
              style: registerToKometTextStyle,
            ),
          )),
          Center(
              child: Container(
            child: SignUpForm(),
          )),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      child: Text('Have an account? ',
                          style: Theme.of(context).textTheme.bodyText1)),
                  TextLink('Login', (context) {
                    Navigator.pop(context);
                    showSignIn(context);
                  }, signUpTextLinksBold, signUpTextLinksHoverBold, context),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'By registering, you agree to our ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 10),
                  ),
                  TextLink(
                      'Terms of Service',
                      (context) {},
                      signUpTextLinks.copyWith(fontSize: 10),
                      signUpTextLinksHover.copyWith(fontSize: 10),
                      context),
                  Text(' and ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 10)),
                  TextLink(
                      'Privacy Policy',
                      (context) {},
                      signUpTextLinks.copyWith(fontSize: 10),
                      signUpTextLinksHover.copyWith(fontSize: 10),
                      context)
                ],
              ),
            ),
          )
        ],
      )),
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
              padding: EdgeInsets.symmetric(vertical: 15),
              constraints: BoxConstraints(maxWidth: 600),
              child: TextFormField(
                onSaved: (value) => signUpModel.firstName = value,
                validator: (firstName) {
                  bool validFirstName = firstName.isNotEmpty;
                  return validFirstName ? null : "Name is required";
                },
                decoration: InputDecoration(
                  border: signUpInputTextBorder,
                  focusedBorder: signUpFocusedInputTextBorder,
                  icon: Icon(
                    Icons.perm_identity,
                    color: Color(0xFF9B9B9B),
                    size: 40,
                  ),
                  labelText: 'First name',
                  labelStyle: labelTextInputStyle,
                ),
                onFieldSubmitted: (value) {
                  trySendRegisterForm(context, signUpModel);
                },
                autofocus: true,
              )),
          Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              constraints: BoxConstraints(maxWidth: 600),
              child: TextFormField(
                onSaved: (value) => signUpModel.email = value,
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
                  labelText: 'Email',
                  labelStyle: labelTextInputStyle,
                ),
                onFieldSubmitted: (value) {
                  trySendRegisterForm(context, signUpModel);
                },
              )),
          Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              constraints: BoxConstraints(maxWidth: 600),
              child: TextFormField(
                onSaved: (value) => signUpModel.password = value,
                obscureText: signUpModel.passwordObfuscated,
                validator: (password) {
                  bool passwordValid = password.isNotEmpty;
                  return passwordValid ? null : "Password is required";
                },
                decoration: InputDecoration(
                  border: signUpInputTextBorder,
                  focusedBorder: signUpFocusedInputTextBorder,
                  suffixIcon: IconButton(
                      onPressed: signUpModel.switchPasswordObfuscation,
                      icon: signUpModel.passwordObfuscated
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
                onFieldSubmitted: (value) {
                  trySendRegisterForm(context, signUpModel);
                },
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
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Wrap(
        children: [
          ElevatedButton(
            onPressed: () {
              trySendRegisterForm(context, signUpModel);
            },
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

void trySendRegisterForm(BuildContext context, SignUpModel signUpModel) {
  if (signUpModel.formValid) {
    if (signUpModel.formKey.currentState.validate()) {
      signUpModel.formKey.currentState.save();
      print(signUpModel.password);
      UserDTO formUser = new UserDTO();
      formUser.email = signUpModel.email;
      formUser.password = signUpModel.password;
      formUser.name = signUpModel.firstName;
      registerUser(formUser)
          .then((value) =>
              //Save credentials
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/', (route) => false))
          .catchError((error) {
        print(error);
      });
    }
  }
}
