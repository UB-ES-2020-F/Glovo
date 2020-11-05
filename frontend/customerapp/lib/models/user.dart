import 'location.dart';

class User {
  int _id;
  String _name;
  String _email;
  String _direction;
  String _directionIndications;
  Location _location;

  static final User _user = User._internal();
  User._internal();

  factory User(
      {int id,
      String name,
      String email,
      String direction,
      String directionIndications,
      Location location}) {
    _user._id = id;
    _user._name = name;
    _user._email = email;
    _user._direction = direction;
    _user._directionIndications = directionIndications;
    _user._location = location;
    return _user;
  }

  int get id {
    return _id;
  }

  String get name {
    return _name;
  }

  String get email {
    return _email;
  }

  String get direction {
    return _direction;
  }

  String get directionIndications {
    return _directionIndications;
  }

  Location get location {
    return _location;
  }
}
