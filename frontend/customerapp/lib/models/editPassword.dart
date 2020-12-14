import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class EditPasswordModel extends ChangeNotifier {
  String oldPassword;
  String newPassword1;
  String newPassword2;

  bool _formValid = false;

  bool _oldPasswordObfuscated = true;
  bool _newPassword1Obfuscated = true;
  bool _newPassword2Obfuscated = true;

  final _formKey = GlobalKey<FormState>();

  bool get oldPasswordObfuscated => _oldPasswordObfuscated;
  bool get newPassword1Obfuscated => _newPassword1Obfuscated;
  bool get newPassword2Obfuscated => _newPassword2Obfuscated;

  GlobalKey<FormState> get formKey => _formKey;

  bool get formValid => _formValid;

  set formValid(bool value) {
    _formValid = value;
    notifyListeners();
  }

  void switchOldPasswordObfuscation() {
    _oldPasswordObfuscated = !_oldPasswordObfuscated;
    notifyListeners();
  }

  void switchNewPassword1Obfuscation() {
    _newPassword1Obfuscated = !_newPassword1Obfuscated;
    notifyListeners();
  }

  void switchNewPassword2Obfuscation() {
    _newPassword2Obfuscated = !_newPassword2Obfuscated;
    notifyListeners();
  }

  void obfuscateAll() {
    _oldPasswordObfuscated = true;
    _newPassword1Obfuscated = true;
    _newPassword2Obfuscated = true;
  }
}
