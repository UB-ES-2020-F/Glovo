import 'package:flutter_driver/flutter_driver.dart';
import '../objectKeys/restaurant.dart';
import 'restaurant_product_card.dart';
import 'driver_page.dart';

class RestaurantPage extends DriverPage {
  RestaurantPage(FlutterDriver driver) : super(driver);
  Future<RestaurantProductCard> getFirstProduct() async {
    return RestaurantProductCard(driver, productCard(0));
  }
}
