import 'package:customerapp/components/text_link.dart';
import 'package:customerapp/dto/user.dart';
import 'package:customerapp/models/changeNameEmail.dart';
import 'package:customerapp/models/forgotPassword.dart';
import 'package:customerapp/models/location.dart';
import 'package:customerapp/models/logged.dart';
import 'package:customerapp/models/signin.dart';
import 'package:customerapp/screens/anon_root.dart';
import 'package:customerapp/screens/commonComponents/single_message_dialog.dart';
import 'package:customerapp/screens/forgotPassword/forgotPassword_success.dart';
import 'package:customerapp/styles/Komet.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:customerapp/styles/signup.dart';
import 'package:provider/provider.dart';
import 'package:customerapp/endpoints/user.dart';
import 'package:customerapp/infrastructure/persistence/repository/user_credentials_repository.dart';
import 'package:customerapp/models/user_credentials/user_credentials.dart';

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height - 150),
            child: ListView(shrinkWrap: true, children: [
              Center(
                  child: Container(
                child: Text(
                  'Forgot your password?',
                  style: registerToKometTextStyle,
                ),
              )),
              ForgotPasswordForm(),
            ])));
  }
}

class ForgotPasswordForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var forgotPasswordModel = context.watch<ForgotPasswordModel>();
    return Form(
      onChanged: () => forgotPasswordModel.formValid =
          forgotPasswordModel.formKey.currentState.validate(),
      key: forgotPasswordModel.formKey,
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              constraints: BoxConstraints(maxWidth: 600),
              child: Text(
                "Enter your email address to reset your password.",
                style: signUpText.copyWith(fontSize: 16),
              )),
          Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              constraints: BoxConstraints(maxWidth: 600),
              child: TextFormField(
                autofocus: true,
                onSaved: (value) => forgotPasswordModel.email = value,
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
                  tryForgotPasswordForm(context, forgotPasswordModel);
                },
              )),
          SaveInformationForgotPasswordButton(),
        ],
      ),
    );
  }
}

/*
  It may be better to pass only formKey as parameter (or the model)
*/
class SaveInformationForgotPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var forgotPasswordModel = context.watch<ForgotPasswordModel>();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Wrap(
        children: [
          ElevatedButton(
            onLongPress: null,
            onPressed: forgotPasswordModel.formValid
                ? () {
                    tryForgotPasswordForm(context, forgotPasswordModel);
                  }
                : null,
            child: Text('Reset'),
            style: forgotPasswordModel.formValid
                ? signUpButtonStyleEnabled
                : signUpButtonStyleDisabled,
          )
        ],
      ),
    );
  }
}

void tryForgotPasswordForm(
    BuildContext context, ForgotPasswordModel forgotPasswordModel) {
  if (forgotPasswordModel.formValid) {
    if (forgotPasswordModel.formKey.currentState.validate()) {
      showLoaderDialog(context);
      forgotPasswordModel.formValid = false;
      forgotPasswordModel.formKey.currentState.save();
      //ENPOINT CALL
      UserDTO formUser = new UserDTO();
      formUser.email = forgotPasswordModel.email;
      sendEmailForgotPassword(formUser).then((value) {
        Navigator.pop(context);
        Navigator.pop(context);
        showForgotPasswordSuccess(context, forgotPasswordModel.email);
      }).catchError((error) {
        print(error);
        Navigator.pop(context);
        showForgotPasswordFailedDialog(context);
      });
    }
  }
}

showForgotPasswordSuccess(BuildContext context, String email) {
  if (MediaQuery.of(context).size.width > 600) {
    showDialog(
        context: context, builder: (_) => ForgotPasswordSuccessDialog(email));
  } else {
    Navigator.pushNamed(context, '/forgot-password-success', arguments: email);
  }
}

showForgotPasswordFailedDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) =>
          SingleMessageDialog("Couldn't send recovery email"));
}
