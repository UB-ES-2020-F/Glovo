import 'package:customerapp/dto/user.dart';
import 'package:customerapp/models/resetPassword.dart';
import 'package:customerapp/screens/commonComponents/single_message_dialog.dart';
import 'package:customerapp/styles/signup.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ResetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Container(padding: EdgeInsets.all(30), child: ResetPassword())
      ]),
    );
  }
}

class ResetPassword extends StatelessWidget {
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
                  'Input your new password:',
                  style: registerToKometTextStyle,
                ),
              )),
              ResetPasswordForm(),
            ])));
  }
}

class ResetPasswordForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var resetPasswordModel = context.watch<ResetPasswordModel>();
    return Form(
      onChanged: () => resetPasswordModel.formValid =
          resetPasswordModel.formKey.currentState.validate(),
      key: resetPasswordModel.formKey,
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
                onSaved: (value) => resetPasswordModel.email = value,
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
                  tryResetPasswordForm(context, resetPasswordModel);
                },
              )),
          ResetPasswordButton(),
        ],
      ),
    );
  }
}

class ResetPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var resetPasswordModel = context.watch<ResetPasswordModel>();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Wrap(
        children: [
          ElevatedButton(
            onLongPress: null,
            onPressed: resetPasswordModel.formValid
                ? () {
                    tryResetPasswordForm(context, resetPasswordModel);
                  }
                : null,
            child: Text('Reset'),
            style: resetPasswordModel.formValid
                ? signUpButtonStyleEnabled
                : signUpButtonStyleDisabled,
          )
        ],
      ),
    );
  }
}

void tryResetPasswordForm(
    BuildContext context, ResetPasswordModel resetPasswordModel) {
  if (resetPasswordModel.formValid) {
    if (resetPasswordModel.formKey.currentState.validate()) {
      showLoaderDialog(context);
      resetPasswordModel.formValid = false;
      resetPasswordModel.formKey.currentState.save();

      //ENDPOINT CALL
      resetPassword().then((value) {
        Navigator.pop(context);
        Navigator.pop(context);
        showResetPasswordSuccess(context);
      }).catchError((error) {
        print(error);
        Navigator.pop(context);
        showResetPasswordFailedDialog(context);
      });
    }
  }
}

showResetPasswordSuccess(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => SingleMessageDialog("Password reset correctly!"));
}

showResetPasswordFailedDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => SingleMessageDialog("Couldn't reset the password"));
}
