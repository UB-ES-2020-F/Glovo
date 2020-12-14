import 'package:flutter_driver/flutter_driver.dart';
import '../objectKeys/restaurants.dart';
import 'driver_page.dart';
import 'restaurant_card.dart';

class RestaurantsPage extends DriverPage {
  RestaurantsPage(FlutterDriver driver) : super(driver);
  Future<void> clickOnFirstRestaurant() async {
    final firstRestaurant = find.byValueKey(restaurantCard(0));
    driver.tap(firstRestaurant);
  }

  Future<RestaurantCard> getRestaurantWithIndex(int index) async {
    return RestaurantCard(driver, restaurantCard(index));
  }
}
