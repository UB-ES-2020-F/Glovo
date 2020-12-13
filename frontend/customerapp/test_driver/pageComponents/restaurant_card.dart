import 'package:flutter_driver/flutter_driver.dart';
import '../objectKeys/restaurant.dart';
import 'driver_page.dart';

class RestaurantCard extends DriverPage {
  String key;
  RestaurantCard(FlutterDriver driver, this.key) : super(driver);

  Future<String> getName() async {
    final restaurantName = find.byValueKey('$key-$name');
    return await driver.getText(restaurantName);
  }
}
