import 'package:flutter/cupertino.dart';

import 'location.dart';

class User {
  int _id;
  String _name;
  String _email;
  String _direction;
  String _directionIndications;
  Location _location;
  VoidCallback callback;

  static final User _user = User._internal();
  User._internal();

  factory User(
      {int id,
      String name,
      String email,
      String direction,
      String directionIndications,
      Location location,
      VoidCallback callback}) {
    _user._id = id;
    _user._name = name;
    _user._email = email;
    _user._direction = direction;
    _user._directionIndications = directionIndications;
    _user._location = location;
    _user.callback = callback;
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

  set id(int value) => _id = value;
  set name(String value) {
    _name = value;
    if (callback != null) callback();
  }

  set email(String value) {
    _email = value;
    if (callback != null) callback();
  }

  set direction(String value) {
    _direction = value;
    if (callback != null) callback();
  }

  set directionIndications(String value) {
    _directionIndications = value;
    if (callback != null) callback();
  }

  set location(Location value) {
    _location = value;
    if (callback != null) callback();
  }
}
