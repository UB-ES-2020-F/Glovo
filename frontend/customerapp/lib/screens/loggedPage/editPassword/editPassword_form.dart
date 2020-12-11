import 'package:customerapp/models/editPassword.dart';
import 'package:customerapp/screens/commonComponents/single_message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:customerapp/styles/signup.dart';
import 'package:provider/provider.dart';
import 'package:customerapp/endpoints/user.dart';
import 'package:customerapp/dto/user.dart';

class EditPassword extends StatelessWidget {
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
                  'Password',
                  style: registerToKometTextStyle,
                ),
              )),
              EditPasswordForm(),
            ])));
  }
}

class EditPasswordForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EditPasswordFormState();
  }
}

class EditPasswordFormState extends State<EditPasswordForm> {
  final _newPassword1Controller = new TextEditingController();
  final _newPassword2Controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    var editPasswordModel = context.watch<EditPasswordModel>();
    return Form(
      onChanged: () => editPasswordModel.formValid =
          editPasswordModel.formKey.currentState.validate(),
      key: editPasswordModel.formKey,
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              constraints: BoxConstraints(maxWidth: 600),
              child: TextFormField(
                enableInteractiveSelection: false,
                onSaved: (value) => editPasswordModel.oldPassword = value,
                obscureText: editPasswordModel.oldPasswordObfuscated,
                validator: (password) {
                  bool passwordValid = password.isNotEmpty;
                  return passwordValid ? null : "Old password is required";
                },
                decoration: InputDecoration(
                  border: signUpInputTextBorder,
                  focusedBorder: signUpFocusedInputTextBorder,
                  suffixIcon: IconButton(
                      onPressed: editPasswordModel.switchOldPasswordObfuscation,
                      icon: editPasswordModel.oldPasswordObfuscated
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
                  labelText: 'Old password',
                  labelStyle: labelTextInputStyle,
                ),
                onFieldSubmitted: (value) {
                  tryEditPasswordForm(context, editPasswordModel);
                },
              )),
          Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              constraints: BoxConstraints(maxWidth: 600),
              child: TextFormField(
                controller: _newPassword1Controller,
                enableInteractiveSelection: false,
                onSaved: (value) => editPasswordModel.newPassword1 = value,
                obscureText: editPasswordModel.newPassword1Obfuscated,
                validator: (password) {
                  bool passwordValid = password.isNotEmpty;
                  return passwordValid ? null : "New password is required";
                },
                decoration: InputDecoration(
                  border: signUpInputTextBorder,
                  focusedBorder: signUpFocusedInputTextBorder,
                  suffixIcon: IconButton(
                      onPressed:
                          editPasswordModel.switchNewPassword1Obfuscation,
                      icon: editPasswordModel.newPassword1Obfuscated
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
                  tryEditPasswordForm(context, editPasswordModel);
                },
              )),
          Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              constraints: BoxConstraints(maxWidth: 600),
              child: TextFormField(
                controller: _newPassword2Controller,
                enableInteractiveSelection: false,
                onSaved: (value) => editPasswordModel.newPassword2 = value,
                obscureText: editPasswordModel.newPassword2Obfuscated,
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
                          editPasswordModel.switchNewPassword2Obfuscation,
                      icon: editPasswordModel.newPassword2Obfuscated
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
                  tryEditPasswordForm(context, editPasswordModel);
                },
              )),
          SaveInformationPasswordButton(),
        ],
      ),
    );
  }
}

/*
  It may be better to pass only formKey as parameter (or the model)
*/
class SaveInformationPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var editPasswordModel = context.watch<EditPasswordModel>();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Wrap(
        children: [
          ElevatedButton(
            onLongPress: null,
            onPressed: editPasswordModel.formValid
                ? () {
                    tryEditPasswordForm(context, editPasswordModel);
                  }
                : null,
            child: Text('Save'),
            style: editPasswordModel.formValid
                ? signUpButtonStyleEnabled
                : signUpButtonStyleDisabled,
          )
        ],
      ),
    );
  }
}

void tryEditPasswordForm(
    BuildContext context, EditPasswordModel editPasswordModel) {
  if (editPasswordModel.formValid) {
    if (editPasswordModel.formKey.currentState.validate()) {
      showLoaderDialog(context);
      editPasswordModel.formKey.currentState.save();
      editPasswordModel.obfuscateAll();

      if (editPasswordModel.newPassword1 != editPasswordModel.newPassword2) {
        Navigator.pop(context);
        showEditPasswordFailedDialog(context);
      } else {
        UserPasswordDTO formPasswords = new UserPasswordDTO();
        formPasswords.oldPassword = editPasswordModel.oldPassword;
        formPasswords.newPassword = editPasswordModel.newPassword1;
        updatePassword(formPasswords).then((value) async {
          Navigator.pop(context); //exit loader
          Navigator.pop(context); //exit changePassword dialog
        }).catchError((error) {
          print(error);
          Navigator.pop(context); //exit loader
          showEditPasswordFailedDialog(context);
        });
      }
    }
  }
}

showEditPasswordFailedDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => SingleMessageDialog("Couldn't change password."));
}
