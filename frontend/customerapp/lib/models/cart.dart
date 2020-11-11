import 'package:customerapp/dto/order.dart';
import 'package:customerapp/models/product/product_overview.dart';
import 'package:flutter/widgets.dart';

class Cart extends ChangeNotifier {
  Map _order = new Map();

  Cart();

  void addItem(Product_overview product) {
    _order.containsKey(product) ? _order[product]++ : _order[product] = 1;
    notifyListeners();
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
    notifyListeners();
  }

  double getTotalPrice() {
    double price = 0.0;
    _order.forEach((k, v) => price += k.price * v);
    return price;
  }

  Map get order {
    return _order;
  }

  void empty() {
    _order.clear();
    notifyListeners();
  }

  int countItems() {
    int numb = 0;
    _order.forEach((k, v) => numb += v);
    return numb;
  }

  OrderDTO generateOrderDTO() {
    //TODO
  }
}
