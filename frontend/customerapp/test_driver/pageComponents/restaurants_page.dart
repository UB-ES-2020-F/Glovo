import 'package:flutter_driver/flutter_driver.dart';
import '../objectKeys/restaurants.dart';
import 'driver_page.dart';

class RestaurantsPage extends DriverPage {
  RestaurantsPage(FlutterDriver driver) : super(driver);
  Future<void> clickOnFirstRestaurant() async {
    final firstRestaurant = find.byValueKey(restaurantCard(0));
    driver.tap(firstRestaurant);
  }
}
