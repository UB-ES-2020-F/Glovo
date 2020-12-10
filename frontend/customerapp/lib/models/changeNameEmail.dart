import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class EditNameEmailModel extends ChangeNotifier {
  String email;
  String firstName;

  bool _formValid = true;

  final _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  bool get formValid => _formValid;

  set formValid(bool value) {
    _formValid = value;
    notifyListeners();
  }
}
