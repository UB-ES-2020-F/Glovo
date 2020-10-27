import 'package:flutter/cupertino.dart';

class SignInModel extends ChangeNotifier {
  String _email;
  String _password;

  bool _formValid = false;

  bool _passwordObfuscated = true;
  final _formKey = GlobalKey<FormState>();

  bool get passwordObfuscated => _passwordObfuscated;
  GlobalKey<FormState> get formKey => _formKey;

  String get email => _email;
  String get password => password;

  bool get formValid => _formValid;

  set email(String value) => _email = value;
  set password(String value) => _password = value;

  set formValid(bool value) {
    _formValid = value;
    notifyListeners();
  }

  void switchPasswordObfuscation() {
    _passwordObfuscated = !_passwordObfuscated;
    notifyListeners();
  }
}
