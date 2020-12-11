import 'package:customerapp/dto/user.dart';
import 'package:customerapp/endpoints/user.dart';
import 'package:customerapp/models/resetPassword.dart';
import 'package:customerapp/screens/commonComponents/single_message_dialog.dart';
import 'package:customerapp/styles/signup.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ResetPasswordPage extends StatelessWidget {
  String email, token;
  ResetPasswordPage({
    this.email,
    this.token,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Container(
            padding: EdgeInsets.all(30),
            child: ResetPassword(email: email, token: token))
      ]),
    );
  }
}

class ResetPassword extends StatelessWidget {
  String email, token;
  ResetPassword({
    this.email,
    this.token,
  });
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
              Text(
                '$email',
                style: registerToKometTextStyle,
              ),
              Text(
                '$token',
                style: registerToKometTextStyle,
              ),
              ResetPasswordForm(email: email, token: token),
            ])));
  }
}

class ResetPasswordForm extends StatefulWidget {
  String email, token;
  ResetPasswordForm({
    this.email,
    this.token,
  });
  @override
  State<StatefulWidget> createState() {
    return ResetPasswordFormState();
  }
}

class ResetPasswordFormState extends State<ResetPasswordForm> {
  final _newPassword1Controller = new TextEditingController();
  final _newPassword2Controller = new TextEditingController();
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
              child: TextFormField(
                controller: _newPassword1Controller,
                enableInteractiveSelection: false,
                onSaved: (value) => resetPasswordModel.newPassword1 = value,
                obscureText: resetPasswordModel.newPassword1Obfuscated,
                validator: (password) {
                  bool passwordValid = password.isNotEmpty;
                  return passwordValid ? null : "New password is required";
                },
                decoration: InputDecoration(
                  border: signUpInputTextBorder,
                  focusedBorder: signUpFocusedInputTextBorder,
                  suffixIcon: IconButton(
                      onPressed:
                          resetPasswordModel.switchNewPassword1Obfuscation,
                      icon: resetPasswordModel.newPassword1Obfuscated
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
                  labelText: 'New password',
                  labelStyle: labelTextInputStyle,
                ),
                onFieldSubmitted: (value) {
                  tryResetPasswordForm(
                      context, resetPasswordModel, widget.email, widget.token);
                },
              )),
          Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              constraints: BoxConstraints(maxWidth: 600),
              child: TextFormField(
                controller: _newPassword2Controller,
                enableInteractiveSelection: false,
                onSaved: (value) => resetPasswordModel.newPassword2 = value,
                obscureText: resetPasswordModel.newPassword2Obfuscated,
                validator: (password) {
                  if (password.isEmpty) return 'Re-enter new password';
                  if (password != _newPassword1Controller.text)
                    return 'Not Match';
                  return null;
                },
                decoration: InputDecoration(
                  border: signUpInputTextBorder,
                  focusedBorder: signUpFocusedInputTextBorder,
                  suffixIcon: IconButton(
                      onPressed:
                          resetPasswordModel.switchNewPassword2Obfuscation,
                      icon: resetPasswordModel.newPassword2Obfuscated
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
                  labelText: 'Repeat new password',
                  labelStyle: labelTextInputStyle,
                ),
                onFieldSubmitted: (value) {
                  tryResetPasswordForm(
                      context, resetPasswordModel, widget.email, widget.token);
                },
              )),
          ResetPasswordButton(email: widget.email, token: widget.token),
        ],
      ),
    );
  }
}

class ResetPasswordButton extends StatelessWidget {
  String email, token;
  ResetPasswordButton({
    this.email,
    this.token,
  });
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
                    tryResetPasswordForm(
                        context, resetPasswordModel, email, token);
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

void tryResetPasswordForm(BuildContext context,
    ResetPasswordModel resetPasswordModel, String email, String token) {
  if (resetPasswordModel.formValid) {
    if (resetPasswordModel.formKey.currentState.validate()) {
      showLoaderDialog(context);
      resetPasswordModel.formKey.currentState.save();
      resetPasswordModel.obfuscateAll();
      resetPasswordModel.formValid = false;
      UserDTO formUser = new UserDTO();
      formUser.email = email;
      formUser.token = token;
      formUser.password = resetPasswordModel.newPassword1;
      //ENDPOINT CALL
      resetPassword(formUser).then((value) {
        Navigator.pop(context); //loader
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/', (route) => false); //mainPage
        showResetPasswordSuccess(context);
      }).catchError((error) {
        print(error);
        Navigator.pop(context); //loader
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
      builder: (context) =>
          SingleMessageDialog("Couldn't reset the password."));
}
