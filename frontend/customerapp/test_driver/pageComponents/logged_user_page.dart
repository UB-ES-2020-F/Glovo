import 'package:flutter_driver/flutter_driver.dart';
import '../objectKeys/logged_page.dart';
import 'driver_page.dart';

class LoggedUserPage extends DriverPage {
  LoggedUserPage(FlutterDriver driver) : super(driver);
  Future<void> clickFoodBubbleButton() async {
    final foodButton = find.byValueKey(foodBubbleButton);
    driver.tap(foodButton);
  }

  Future<void> clickProfileButton() async {
    final profButton = find.byValueKey(profileButton);
    driver.tap(profButton);
  }
}
