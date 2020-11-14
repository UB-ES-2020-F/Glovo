import 'package:customerapp/models/location.dart';
import 'package:customerapp/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class LoggedModel extends ChangeNotifier {
  //testing variables. Will get real variables from backend
  static String firstName = 'Josep Maria';
  static String email = 'pepma@gmail.com';
  static String direction = 'Carrer de Diputació, 234';
  static String indicationsDirection = '4t 2a';
  static int idUser = 99;
  static Location location = new Location(40, 2);

  static User user = new User(
      id: idUser,
      name: firstName,
      email: email,
      direction: direction,
      directionIndications: indicationsDirection,
      location: location);
}
