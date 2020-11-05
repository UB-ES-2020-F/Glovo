import 'location.dart';

class User {
  int _id;
  String _name;
  String _email;
  String _direction;
  String _directionIndications;
  Location _location;

  User(this._id, this._name, this._email, this._direction,
      this._directionIndications, this._location);

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
