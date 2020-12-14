import 'dart:convert';

import 'package:customerapp/dto/location.dart';
import 'package:customerapp/endpoints/urls.dart';
import 'package:customerapp/exceptions/logout-callback-failed.dart';
import 'package:customerapp/infrastructure/persistence/repository/user_credentials_repository.dart';
import 'package:http/http.dart' as http;

Future<LocationDTO> savelocation(LocationDTO location) async {
  final userCredentials = await UserCredentialsRepository().getCredentials();
  final response = await http.post(await EndpointDefinitions.makeLocationPost(),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${userCredentials.token}'
      },
      body: jsonEncode(location.toJson()));
  if (response.statusCode == 200) {
    return LocationDTO.fromJson(jsonDecode(response.body));
  } else {
    throw LogoutCallbackFailed(
        'Failed to login', response.statusCode, response.body);
  }
}

Future<LocationDTO> getlocation() async {
  final userCredentials = await UserCredentialsRepository().getCredentials();
  final response =
      await http.get(await EndpointDefinitions.makeLocationPost(), headers: {
    "Content-Type": "application/json",
    'Authorization': 'Bearer ${userCredentials.token}'
  });
  if (response.statusCode == 200) {
    LocationDTO location = LocationDTO.fromJson(
        (json.decode(response.body) as Map<String, dynamic>));

    return location;
  } else {
    throw LogoutCallbackFailed(
        'Failed to login', response.statusCode, response.body);
  }
}
