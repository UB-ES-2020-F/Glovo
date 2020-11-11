import 'dart:convert';

import 'package:customerapp/dto/order.dart';
import 'package:customerapp/endpoints/urls.dart';
import 'package:customerapp/exceptions/order-callback-failed.dart';
import 'package:http/http.dart' as http;

Future<OrderDTO> makeOrder(OrderDTO order) async {
  final response = await http.post(makeUrl(EndpointDefinitions.ORDERS),
      headers: {"Content-Type": "application/json"},
      body: json.encode(order.toJson()));
  if (response.statusCode == 200) {
    return OrderDTO.fromJson(jsonDecode(response.body));
  } else {
    throw OrderCallbackFailed(
        'Failed to make an order', response.statusCode, response.body);
  }
}
