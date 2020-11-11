import 'package:flutter_driver/flutter_driver.dart';

import '../objectKeys/anonymous_page.dart';
import 'driver_page.dart';

class AnonymousePage extends DriverPage {
  AnonymousePage(FlutterDriver driver) : super(driver);
  Future<void> clickLoginButton() async {
    final logInButton = find.byValueKey(loginButton);
    await driver.tap(logInButton);
  }
}
