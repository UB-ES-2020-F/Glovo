import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class EditNameEmailModel extends ChangeNotifier {
  String _email;
  String _firstName;

  bool _formValid = true;

  final _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  String get email => _email;
  String get firstName => _firstName;

  bool get formValid => _formValid;

  set email(String value) => _email = value;
  set firstName(String value) => _firstName = value;

  set formValid(bool value) {
    _formValid = value;
    notifyListeners();
  }
}
