import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class SignInModel extends ChangeNotifier {
  String email;
  String password;

  bool _formValid = false;

  bool _passwordObfuscated = true;
  final _formKey = GlobalKey<FormState>();

  bool get passwordObfuscated => _passwordObfuscated;
  GlobalKey<FormState> get formKey => _formKey;

  bool get formValid => _formValid;

  set formValid(bool value) {
    _formValid = value;
    notifyListeners();
  }

  void switchPasswordObfuscation() {
    _passwordObfuscated = !_passwordObfuscated;
    notifyListeners();
  }
}
