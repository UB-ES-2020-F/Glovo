import 'package:customerapp/dto/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'location.dart';

class RestaurantsListModel extends ChangeNotifier {
  List<Restaurant> availableRestaurants;

  @override
  RestaurantsListModel() {
    availableRestaurants = List();
  }

  /*
   * Not recommended approach, the best approach would be to use the constructor
   */
  void addRestaurant(Restaurant restaurant) {
    availableRestaurants.add(restaurant);
  }

  void removeRestaurants() {
    availableRestaurants.clear();
  }
}

class Restaurant {
  int id;
  String _name;
  String _image;
  Location _location;
  Restaurant(this.id, this._name, this._image, this._location);

  String get name {
    return _name;
  }

  String get image {
    return _image;
  }

  Location get location {
    return _location;
  }

  factory Restaurant.fromDTO(RestaurantDTO restaurantDTO) {
    return Restaurant(restaurantDTO.id, restaurantDTO.name,
        restaurantDTO.imgPath, restaurantDTO.location);
  }

  RestaurantDTO toDTO() {
    return RestaurantDTO(
        id: this.id,
        name: this.name,
        imgPath: this.image,
        location: this.location);
  }
}

double getDeliveryFee(double distance) {
  return distance == null ? -1 : ((distance * 5).toInt() / 10);
}

class TimeInterval {
  int min;
  int max;

  TimeInterval(int min, int max) {
    assert(min <= max);
    this.min = min;
    this.max = max;
  }

  TimeInterval.distance(double distance) {
    if (distance == null) {
      this.max = -1;
      this.min = -1;
    } else {
      double time = 10 + distance * 2;
      int uncertainty = 5;
      this.min = (time ~/ 5) * 5 - uncertainty;
      this.max = (time ~/ 5) * 5 + uncertainty;
    }
  }
}

class RestaurantLoc {
  int id;
  String _name;
  String _image;
  double deliveryFee;
  double distance;
  RestaurantLoc(
      this.id, this._name, this._image, this.distance, this.deliveryFee);

  String get name {
    return _name;
  }

  String get image {
    return _image;
  }

  factory RestaurantLoc.fromDTO(Restaurant_feeDTO restaurantDTO) {
    return RestaurantLoc(
        restaurantDTO.id,
        restaurantDTO.name,
        restaurantDTO.imgPath,
        restaurantDTO.distance,
        restaurantDTO.deliveryFee);
  }

  /*RestaurantDTO toDTO() {
    return RestaurantDTO(
        id: this.id,
        name: this.name,
        imgPath: this.image,
        location: this.location);
  }*/
}

class RestaurantsListModel_fee extends ChangeNotifier {
  List<RestaurantLoc> availableRestaurants;

  @override
  RestaurantsListModel_fee() {
    availableRestaurants = List();
  }

  /*
   * Not recommended approach, the best approach would be to use the constructor
   */
  void addRestaurant(RestaurantLoc restaurant) {
    availableRestaurants.add(restaurant);
  }

  void removeRestaurants() {
    availableRestaurants.clear();
  }
}
