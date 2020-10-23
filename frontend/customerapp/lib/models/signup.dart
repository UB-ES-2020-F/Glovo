import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class SignUpModel extends ChangeNotifier {
  String _name;
  String _email;
  String _password;

  String get name => _name;
  String get email => email;
  String get password => password;

  set name(String name) => name = name;
  set email(String email) => _email = email;
  set password(String password) => _password = password;
}
