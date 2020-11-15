import 'package:flutter_test/flutter_test.dart';

import '../../data/products.dart';
import '../../data/restaurants.dart';
import '../../endpointComponents/restaurants_endpoint.dart';

void main() {
  group('Restaurants endpoint tests', () {
    test(
        'it retrieves products of a given category of an existing restaurant when the category exists',
        () async {
      final order = await getRestaurantProductsOfCategory(
          validRestaurantId, validCategory);
      expect(order.products.length, greaterThan(1));
    });
    test(
        'it retrieves 0 products of a given category of an existing restaurant when the category does not exists',
        () async {
      bool categoryNotFound = false;
      try {
        await getRestaurantProductsOfCategory(
            validRestaurantId, invalidCategory);
      } catch (ex) {
        categoryNotFound = true;
      }
      expect(categoryNotFound, true);
    });
  });
}
