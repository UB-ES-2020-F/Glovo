import 'dart:convert';

import 'package:http/http.dart' as http;
import '../dto/user.dart';
import 'endpoints_definitions.dart';

Future<int> createUser(String name, String email, String password) async {
  final body = {'name': name, 'email': email, 'password': password};
  final response = await http.post(CREATE_USER,
      headers: {'content-type': 'application/json'}, body: json.encode(body));
  return response.statusCode;
}

Future<UserDTO> login(String email, String password) async {
  UserDTO body = UserDTO(email: email, password: password);
  final response = await http.post(USER_LOGIN,
      headers: {'content-type': 'application/json'},
      body: json.encode(body.toJson()));
  return UserDTO.fromJson(json.decode(response.body));
}
