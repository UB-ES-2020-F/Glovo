import 'package:customerapp/dto/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'location.dart';

class RestaurantsListModel extends ChangeNotifier {
  List<Restaurant> availableRestaurants;

  //RestaurantsListModel(List<Restaurant> restaurants);

  // only for mocking data. Delete when endpoint is finished
  @deprecated
  @override
  RestaurantsListModel() {
    availableRestaurants = List();
    /*
    availableRestaurants.add(Restaurant(
        1,
        'La Tagliatella',
        'https://cdn2.cocinadelirante.com/sites/default/files/images/2018/12/como-hacer-cremosa-pasta-hervida-en-leche.jpeg',
        new Location(40, 2.1)));
    availableRestaurants.add(Restaurant(
        2,
        'Burger King',
        'https://www.familycheck.es/wp-content/uploads/2019/11/Burger-King-1.jpg',
        new Location(40.1, 2)));
    availableRestaurants.add(Restaurant(
        3,
        "McDonald's",
        'https://cdn.ticbeat.com/src/uploads/2018/06/mcdonalds-burger-king-subway-europa-810x547.jpg',
        new Location(40.1, 2)));
    availableRestaurants.add(Restaurant(
        4,
        'Five Guys',
        'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/img-0056-1575287109.jpg',
        new Location(40, 2.1)));
        */
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
