import 'dart:convert';

import 'package:customerapp/dto/product.dart';
import 'package:customerapp/endpoints/urls.dart';
import 'package:customerapp/exceptions/order-callback-failed.dart';
import 'package:http/http.dart' as http;

Future<List<ProductDTO>> getProductsFromRestaurant(int restaurantId) async {
  final response = await http.get(
      await EndpointDefinitions.makeRestaurantsProductsURL(restaurantId),
      headers: {
        "Content-Type": "application/json",
      });
  if (response.statusCode == 200) {
    List<ProductDTO> products = (json.decode(response.body) as List)
        .map((i) => ProductDTO.fromJson(i))
        .toList();
    return products;
  } else {
    throw OrderCallbackFailed(
        'Failed to login', response.statusCode, response.body);
  }
}
