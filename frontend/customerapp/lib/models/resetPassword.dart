import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ResetPasswordModel extends ChangeNotifier {
  String _newPassword1;
  String _newPassword2;

  bool _formValid = false;

  bool _newPassword1Obfuscated = true;
  bool _newPassword2Obfuscated = true;

  final _formKey = GlobalKey<FormState>();

  bool get newPassword1Obfuscated => _newPassword1Obfuscated;
  bool get newPassword2Obfuscated => _newPassword2Obfuscated;

  GlobalKey<FormState> get formKey => _formKey;

  String get newPassword1 => _newPassword1;
  String get newPassword2 => _newPassword2;

  bool get formValid => _formValid;

  set newPassword1(String value) => _newPassword1 = value;
  set newPassword2(String value) => _newPassword2 = value;

  set formValid(bool value) {
    _formValid = value;
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
    _newPassword1Obfuscated = true;
    _newPassword2Obfuscated = true;
  }
}
