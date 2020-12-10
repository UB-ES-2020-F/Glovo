import 'location.dart';

class User {
  int id;
  String name;
  String email;
  String direction;
  String directionIndications;
  Location location;

  static final User _user = User._internal();
  User._internal();

  factory User(
      {int id,
      String name,
      String email,
      String direction,
      String directionIndications,
      Location location}) {
    _user.id = id;
    _user.name = name;
    _user.email = email;
    _user.direction = direction;
    _user.directionIndications = directionIndications;
    _user.location = location;
    return _user;
  }
}
