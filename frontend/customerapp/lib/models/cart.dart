import 'package:customerapp/dto/order.dart';
import 'package:customerapp/infrastructure/persistence/repository/user_credentials_repository.dart';
import 'package:customerapp/models/products.dart';
import 'package:flutter/widgets.dart';

class Cart extends ChangeNotifier {
  Map _order = new Map();

  Cart();

  void addItem(Product product) {
    _order.containsKey(product) ? _order[product]++ : _order[product] = 1;
    notifyListeners();
  }

  void substractItem(Product product) {
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

  Future<OrderDTO> generateOrderDTO() async {
    return OrderDTO(
        restaurantId: _getRestaurantId(),
        products: _getProductsDTOs());
  }

  List<ProductDTO> _getProductsDTOs() {
    return _order.entries
        .map((product) =>
            ProductDTO((product.key as Product).idProd, product.value))
        .toList();
  }

  int _getRestaurantId() {
    return (order.entries.first.key as Product).idRestaurant;
  }
}
