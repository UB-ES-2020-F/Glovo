import 'package:customerapp/models/product/product_overview.dart';
import 'package:customerapp/models/restaurants.dart';
import 'package:customerapp/models/user.dart';

class Cart {
  Map _order = new Map();

  Cart();

  void addItem(Product_overview product) {
    _order.containsKey(product) ? _order[product]++ : _order[product] = 1;
  }

  void substractItem(Product_overview product) {
    if (_order.containsKey(product)) {
      _order[product]--;
      if (_order[product] == 0) {
        _order.remove(product);
      }
    } else {
      throw new FormatException("No product to remove");
    }
  }

  double getTotalPrice() {
    double price = 0.0;
    _order.forEach((k, v) => price += k.price * v);
    return price;
  }

  Map get order {
    return _order;
  }
}
