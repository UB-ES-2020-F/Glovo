import 'dart:convert';
import 'dart:io';

import 'package:customerapp/dto/order.dart';
import 'package:customerapp/endpoints/urls.dart';
import 'package:customerapp/exceptions/order-callback-failed.dart';
import 'package:http/http.dart' as http;

Future<OrderDTO> makeOrder(OrderDTO order) async {
  try {
    final response = await http.post(await makeUrl(EndpointDefinitions.ORDERS),
        //headers: {"content-type": "application/json",},
        body: json.encode(order.toJson()));
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return OrderDTO.fromJson(jsonDecode(response.body));
    } else {
      throw OrderCallbackFailed(
          'Failed to make an order', response.statusCode, response.body);
    }
  } catch (ex) {
    print(ex.toString());
  }
}
