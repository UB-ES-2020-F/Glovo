import 'dart:convert';

import 'package:http/http.dart' as http;
import '../data/exception_messages.dart';
import '../dto/products.dart';
import '../dto/restaurants.dart';
import 'endpoints_definitions.dart';

Future<ProductsDTO> getRestaurantProductsOfCategory(
    int restaurantId, int categoryId) async {
  final response = await http
      .get(PRODUCTS_OF_RESTAURANT_BY_CATEGORY(restaurantId, categoryId));
  if (response.statusCode != 200) throw Exception(CATEGORY_DOES_NOT_EXIST);
  return ProductsDTO.fromJson(json.decode(response.body));
}

Future<RestaurantsDTO> getClosestRestaurants(
    double latitude, double longitude) async {
  final response = await http.get(CLOSEST_RESTAURANTS(latitude, longitude));
  if (response.statusCode != 200) throw Exception(BAD_INPUT);
  return RestaurantsDTO.fromJson(json.decode(response.body));
}

Future<RestaurantsDTO> getAllRestaurants() async {
  final response = await http.get(RESTAURANTS);
  if (response.statusCode != 200) throw Exception(BAD_INPUT);
  return RestaurantsDTO.fromJson(json.decode(response.body));
}
