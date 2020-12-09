import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ResetPasswordModel extends ChangeNotifier {
  String _email;

  bool _formValid = false;

  final _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  String get email => _email;

  bool get formValid => _formValid;

  set email(String value) => _email = value;

  set formValid(bool value) {
    _formValid = value;
    notifyListeners();
  }
}
