import 'dart:convert';

import 'package:customerapp/dto/order.dart';
import 'package:customerapp/endpoints/urls.dart';
import 'package:customerapp/exceptions/order-callback-failed.dart';
import 'package:customerapp/infrastructure/persistence/repository/user_credentials_repository.dart';
import 'package:http/http.dart' as http;

Future<OrderDTO> makeOrder(OrderDTO order) async {
  try {
    print("report:");
    print(order.toJson());
    final userCredentials = await UserCredentialsRepository().getCredentials();

    final response = await http.post(await EndpointDefinitions.makeOrdersURL(),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer ${userCredentials.token}'
        },
        
        body: json.encode(order.toJson()));
    if (response.statusCode == 200) {
      return OrderDTO.fromJson(jsonDecode(response.body));
    } else {
      throw OrderCallbackFailed(
          'Failed to make an order', response.statusCode, response.body);
    }
  } catch (ex) {
    return Future.error(ex);
  }
}
