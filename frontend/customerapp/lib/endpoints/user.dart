import 'dart:convert';

import 'package:customerapp/dto/user.dart';
import 'package:customerapp/endpoints/urls.dart';
import 'package:customerapp/exceptions/logout-callback-failed.dart';
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
    throw LogoutCallbackFailed(
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
    throw LogoutCallbackFailed(
        'Failed to register', response.statusCode, response.body);
  }
}

Future<void> logout() async {
  final userCredentials = await UserCredentialsRepository().getCredentials();
  final response =
      await http.post(await EndpointDefinitions.makeLogoutURL(), headers: {
    "Content-Type": "application/json",
    'Authorization': 'Bearer ${userCredentials.token}'
  });
  if (response.statusCode == 200) {
    return;
  } else {
    throw LogoutCallbackFailed(
        'Failed to logout', response.statusCode, response.body);
  }
}

Future<void> sendEmailForgotPassword(String email) async {
  final response = await http.post(await EndpointDefinitions.makeRegisterURL(),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(email));
  if (response.statusCode == 200) {
    return;
  } else {
    throw LogoutCallbackFailed(
        'Failed to send recovery email', response.statusCode, response.body);
  }
}
