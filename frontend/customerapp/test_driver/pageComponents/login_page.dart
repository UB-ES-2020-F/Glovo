import 'package:flutter_driver/flutter_driver.dart';
import '../objectKeys/login.dart';
import 'driver_page.dart';

class LoginPage extends DriverPage {
  LoginPage(FlutterDriver driver) : super(driver);

  Future<void> fillEmail(String email) async {
    final emailField = find.byValueKey(emailTextField);
    await driver.tap(emailField);
    await driver.enterText(email);
  }

  Future<void> fillPassword(String password) async {
    final passwordField = find.byValueKey(passwordTextField);
    await driver.tap(passwordField);
    await driver.enterText(password);
  }

  Future<void> clickSubmitLogin() async {
    final logInSubmitButton = find.byValueKey(loginSubmitButton);
    await driver.tap(logInSubmitButton);
  }
}
