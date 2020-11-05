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
    availableRestaurants.add(Restaurant(
        1,
        'La Tagliatella',
        'https://cdn2.cocinadelirante.com/sites/default/files/images/2018/12/como-hacer-cremosa-pasta-hervida-en-leche.jpeg',
        new Location(40, 2)));
    availableRestaurants.add(Restaurant(
        2,
        'Burger King',
        'https://www.familycheck.es/wp-content/uploads/2019/11/Burger-King-1.jpg',
        new Location(40, 2)));
    availableRestaurants.add(Restaurant(
        3,
        "McDonald's",
        'https://cdn.ticbeat.com/src/uploads/2018/06/mcdonalds-burger-king-subway-europa-810x547.jpg',
        new Location(40, 2)));
    availableRestaurants.add(Restaurant(
        4,
        'Five Guys',
        'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/img-0056-1575287109.jpg',
        new Location(40, 2)));
  }

  /*
   * Not recommended approach, the best approach would be to use the constructor
   */
  addRestaurant(Restaurant restaurant) {
    availableRestaurants.add(restaurant);
  }
}

class Restaurant {
  int id;
  String name;
  String image;
  Location _location;
  Restaurant(this.id, this.name, this.image, this._location);
}

double getDeliveryFee(double distance) {
  return distance * 1;
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
    int time = 20;
    int uncertainty = 5;
    this.min = (time ~/ 5) * 5 - uncertainty;
    this.max = (time ~/ 5) * 5 + uncertainty;
  }
}
