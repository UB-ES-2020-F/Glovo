import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class SignUpModel extends ChangeNotifier {
  String _firstName;
  String _email;
  String _password;
  bool _passwordObfuscated = true;
  final _formKey = GlobalKey<FormState>();
  bool get passwordObfuscated => _passwordObfuscated;
  String get firstName => _firstName;
  String get email => _email;
  String get password => password;
  set firstName(String value) => _firstName = value;
  set email(String value) => _email = value;
  set password(String value) => _password = value;
  GlobalKey<FormState> get formKey => _formKey;
  void switchPasswordObfuscation() {
    _passwordObfuscated = !_passwordObfuscated;
    notifyListeners();
  }
}
