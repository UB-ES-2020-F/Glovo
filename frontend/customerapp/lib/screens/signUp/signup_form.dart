import 'package:customerapp/components/text_link.dart';
import 'package:customerapp/dto/user.dart';
import 'package:customerapp/infrastructure/persistence/repository/user_credentials_repository.dart';
import 'package:customerapp/models/location.dart';
import 'package:customerapp/models/logged.dart';
import 'package:customerapp/models/signup.dart';
import 'package:customerapp/models/user_credentials/user_credentials.dart';
import 'package:customerapp/screens/anon_root.dart';
import 'package:customerapp/screens/signIn/signin_form.dart';
import 'package:customerapp/screens/commonComponents/single_message_dialog.dart';
import 'package:customerapp/styles/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:customerapp/endpoints/user.dart';

class SignUpFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height - 150),
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
                          child: Text('Have an account? ', style: signUpText)),
                      TextLink('Login', (context) {
                        Navigator.pop(context);
                        showSignIn(context);
                      }, signUpTextLinks, signUpTextLinksHover, context),
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Text(
                        'By registering, you agree to our ',
                        style: signUpText.copyWith(fontSize: 10),
                      ),
                      TextLink(
                          'Terms of Service',
                          (context) {},
                          signUpTextLinks.copyWith(fontSize: 10),
                          signUpTextLinksHover.copyWith(fontSize: 10),
                          context),
                      Text(' and ', style: signUpText.copyWith(fontSize: 10)),
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
            onLongPress: null,
            onPressed: signUpModel.formValid
                ? () {
                    trySendRegisterForm(context, signUpModel);
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

void trySendRegisterForm(BuildContext context, SignUpModel signUpModel) {
  if (signUpModel.formValid) {
    if (signUpModel.formKey.currentState.validate()) {
      showLoaderDialog(context);
      signUpModel.formValid = false;
      signUpModel.formKey.currentState.save();
      UserDTO formUser = new UserDTO();
      formUser.email = signUpModel.email;
      formUser.password = signUpModel.password;
      formUser.name = signUpModel.firstName;
      registerUser(formUser).then((value) {
        loginUser(formUser).then((loggedUser) async {
          UserCredentialsRepository().update(new UserCredentials(
              loggedUser.email, loggedUser.token, loggedUser.id));
          LoggedModel.user.id = loggedUser.id;
          LoggedModel.user.name = loggedUser.name;
          LoggedModel.user.email = loggedUser.email;
          LoggedModel.user.location = new Location(40, 2);
          LoggedModel.user.direction = 'Unknown direction';          
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/initial-logged-in', (route) => false);
        }).catchError((error) {
          print(error);
          Navigator.pop(context);
          showLogInFailedDialog(context);
        });
      }).catchError((error) {
        print(error);
        Navigator.pop(context);
        showSignUpFailedDialog(context);
      });
    }
  }
}

showSignUpFailedDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => SingleMessageDialog("Sign up failed"));
}
