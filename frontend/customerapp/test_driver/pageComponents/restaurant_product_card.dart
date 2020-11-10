import 'package:flutter_driver/flutter_driver.dart';
import '../objectKeys/restaurant.dart';
import 'driver_page.dart';

class RestaurantProductCard extends DriverPage {
  String key;
  RestaurantProductCard(FlutterDriver driver, this.key) : super(driver);

  Future<void> addToCart() async {
    final addProductToCartButton = find.byValueKey('$key-$productAddToCart');
    await driver.tap(addProductToCartButton);
  }
}
