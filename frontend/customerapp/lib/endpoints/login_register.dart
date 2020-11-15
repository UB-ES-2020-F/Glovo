import 'dart:convert';
import 'dart:io';

import 'package:customerapp/dto/user.dart';
import 'package:customerapp/endpoints/urls.dart';
import 'package:customerapp/exceptions/order-callback-failed.dart';
import 'package:customerapp/infrastructure/persistence/repository/user_credentials_repository.dart';
import 'package:http/http.dart' as http;

Future<UserDTO> loginUser(UserDTO formUser) async {
  final response = await http.post(await EndpointDefinitions.makeLoginURL(),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(formUser.toJson()));
  if (response.statusCode == 200) {
    return UserDTO.fromJson(jsonDecode(response.body));
  } else {
    throw OrderCallbackFailed(
        'Failed to login', response.statusCode, response.body);
  }
}

Future<void> registerUser(UserDTO formUser) async {
  final response = await http.post(await EndpointDefinitions.makeRegisterURL(),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(formUser.toJson()));
  if (response.statusCode == 200) {
    return;
  } else {
    throw OrderCallbackFailed(
        'Failed to register', response.statusCode, response.body);
  }
}
