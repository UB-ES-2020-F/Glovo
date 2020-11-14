import 'package:flutter_driver/flutter_driver.dart';

import '../actions/check-is-present.dart';
import '../objectKeys/cart.dart';
import 'cart_item.dart';
import 'driver_page.dart';

class CartPage extends DriverPage {
  CartPage(FlutterDriver driver) : super(driver);
  Future<bool> cartIsEmpty() async {
    final firstItemOnCart = find.byValueKey(itemOnCart(0));
    return !(await isPresent(firstItemOnCart, driver));
  }

  Future<int> countElementsInCart() async {
    if (await cartIsEmpty()) return 0;
    return _getNumberOfElementsInCart();
  }

  Future<int> _getNumberOfElementsInCart() async {
    var numberOfElements = 0;
    while (await isPresent(
        find.byValueKey(itemOnCart(numberOfElements)), driver)) {
      numberOfElements++;
    }
    return numberOfElements;
  }

  Future<CartItem> getFirstCartItem() async {
    return CartItem(driver, itemOnCart(0));
  }
}
