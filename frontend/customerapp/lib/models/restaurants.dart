import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

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
        TimeInterval(10, 20),
        2.5,
        'https://cdn2.cocinadelirante.com/sites/default/files/images/2018/12/como-hacer-cremosa-pasta-hervida-en-leche.jpeg'));
    availableRestaurants.add(Restaurant(
        1,
        'Burger King',
        TimeInterval(20, 30),
        4,
        'https://www.familycheck.es/wp-content/uploads/2019/11/Burger-King-1.jpg'));
    availableRestaurants.add(Restaurant(
        1,
        "McDonald's",
        TimeInterval(20, 30),
        4,
        'https://cdn.ticbeat.com/src/uploads/2018/06/mcdonalds-burger-king-subway-europa-810x547.jpg'));
    availableRestaurants.add(Restaurant(1, 'Five Guys', TimeInterval(20, 30), 4,
        'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/img-0056-1575287109.jpg'));
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
  TimeInterval expectedDeliveryTime;
  double deliveryFee;
  String image;
  Restaurant(this.id, this.name, this.expectedDeliveryTime, this.deliveryFee,
      this.image);
}

class TimeInterval {
  int min;
  int max;

  TimeInterval(int min, int max) {
    assert(min <= max);
    this.min = min;
    this.max = max;
  }
}
