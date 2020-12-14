import 'dart:convert';

import 'package:customerapp/dto/restaurant.dart';
import 'package:customerapp/endpoints/urls.dart';
import 'package:customerapp/exceptions/order-callback-failed.dart';
import 'package:http/http.dart' as http;

Future<List<RestaurantDTO>> getRestaurants() async {
  final response =
      await http.get(await EndpointDefinitions.makeRestaurantsURL(), headers: {
    "Content-Type": "application/json",
  });
  if (response.statusCode == 200) {
    List<RestaurantDTO> restaurants = (json.decode(response.body) as List)
        .map((i) => RestaurantDTO.fromJson(i))
        .toList();
    return restaurants;
  } else {
    throw OrderCallbackFailed(
        'Failed to login', response.statusCode, response.body);
  }
}

Future<List<Restaurant_feeDTO>> getRestaurantsLoc(
    double lat, double long) async {
  String url = await EndpointDefinitions.makeRestaurantsURL() +
      "/closest?latitude=${lat.toString()}&longitude=${long.toString()}";

  final response = await http.get(url, headers: {
    "Content-Type": "application/json",
  });
  if (response.statusCode == 200) {
    List<Restaurant_feeDTO> restaurants = (json.decode(response.body) as List)
        .map((i) => Restaurant_feeDTO.fromJson(i))
        .toList();
    return restaurants;
  } else {
    throw OrderCallbackFailed(
        'Failed to login', response.statusCode, response.body);
  }
}
