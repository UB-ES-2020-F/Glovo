import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ForgotPasswordModel extends ChangeNotifier {
  String email;

  bool _formValid = false;

  final _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  bool get formValid => _formValid;

  set formValid(bool value) {
    _formValid = value;
    notifyListeners();
  }
}
