import 'dart:convert';

import 'package:http/http.dart' as http;
import '../dto/order.dart';
import 'endpoints_definitions.dart';

Future<int> doOrder(OrderDTO orderDTO, String token) async {
  final response = await http.post(ORDERS,
      headers: {
        'content-type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json.encode(orderDTO.toJson()));
  return response.statusCode;
}
