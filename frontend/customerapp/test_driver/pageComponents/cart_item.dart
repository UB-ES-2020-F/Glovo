import 'package:flutter_driver/flutter_driver.dart';
import '../objectKeys/cart.dart';
import 'driver_page.dart';

class CartItem extends DriverPage {
  String key;
  CartItem(FlutterDriver driver, this.key) : super(driver);

  Future<void> removeFromCart() async {
    final removeItemFromCartButton = find.byValueKey('$key-$removeItem');
    await driver.tap(removeItemFromCartButton);
  }
}
