import 'package:flutter_test/flutter_test.dart';

import '../../data/login.dart';
import '../../data/products.dart';
import '../../data/restaurants.dart';
import '../../dto/order.dart';
import '../../dto/user.dart';
import '../../endpointComponents/orders_endpoint.dart';
import '../../endpointComponents/user_endpoint.dart';

void main() {
  group('Orders endpoint tests', () {
    UserDTO user;
    setUpAll(() async {
      await createUser(validName, validUserEmail, validUserPassword);
      user = await login(validUserEmail, validUserPassword);
    });
    test('it creates an order when the data is correct', () async {
      final order = await generateValidOrder(user);
      final responseCode = await doOrder(order, user.token);
      expect(responseCode, 200);
    });
    test('it returns an error when the restaurant does not exist', () async {
      final order = await generateOrderInvalidRestaurant(user);
      final responseCode = await doOrder(order, user.token);
      expect(responseCode, 400);
    });
    test(
        'it returns an error when the restaurant exists but the product does not exist',
        () async {
      final order = await generateOrderInvalidProduct(user);
      final responseCode = await doOrder(order, user.token);
      expect(responseCode, 400);
    });
  });
}

Future<OrderDTO> generateValidOrder(UserDTO user) async {
  return await generateOrder(user, validRestaurantId, validProductId);
}

Future<OrderDTO> generateOrderInvalidRestaurant(UserDTO user) async {
  return await generateOrder(user, invalidRestaurantId, validProductId);
}

Future<OrderDTO> generateOrderInvalidProduct(UserDTO user) async {
  return await generateOrder(user, validRestaurantId, invalidProductId);
}

Future<OrderDTO> generateOrder(
    UserDTO user, int restaurantId, int productId) async {
  return OrderDTO(
      userId: user.id,
      buyDateTime: DateTime.now(),
      restaurantId: restaurantId,
      products: [ProductDTO(productId, 1)]);
}
