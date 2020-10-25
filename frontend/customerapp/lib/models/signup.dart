import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class SignUpModel extends ChangeNotifier {
  bool _passwordObfuscated = true;
  final _formKey = GlobalKey<FormState>();
  bool get passwordObfuscated => _passwordObfuscated;
  GlobalKey<FormState> get formKey => _formKey;
  void switchPasswordObfuscation() {
    _passwordObfuscated = !_passwordObfuscated;
    notifyListeners();
  }
}
