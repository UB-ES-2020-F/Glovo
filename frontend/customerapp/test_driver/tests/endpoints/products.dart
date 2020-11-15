import 'package:flutter_test/flutter_test.dart';

import '../../data/products.dart';
import '../../endpointComponents/products_endpoint.dart';

void main() {
  group('Products endpoint tests', () {
    test('it retrieves products of a given category when the category exists',
        () async {
      final order = await getProductsOfCategory(validCategory);
      expect(order.products.length, greaterThan(1));
    });
    test(
        'it retrieves 0 products of a given category when the category does not exists',
        () async {
      bool categoryNotFound = false;
      try {
        await getProductsOfCategory(invalidCategory);
      } catch (ex) {
        categoryNotFound = true;
      }
      expect(categoryNotFound, true);
    });
  });
}
