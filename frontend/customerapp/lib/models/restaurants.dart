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
        'Tagliatella',
        TimeInterval(10, 20),
        2.5,
        'https://dam.cocinafacil.com.mx/wp-content/uploads/2020/04/dumplings.jpg'));
    availableRestaurants.add(Restaurant(
        1,
        'Burger King',
        TimeInterval(20, 30),
        4,
        'https://dam.cocinafacil.com.mx/wp-content/uploads/2020/04/Cerdo-agridulce.jpg'));
    availableRestaurants.add(Restaurant(1, 'McDonalds', TimeInterval(20, 30), 4,
        'https://dam.cocinafacil.com.mx/wp-content/uploads/2020/04/chow-mein.jpg'));
    availableRestaurants.add(Restaurant(1, 'FiveGuys', TimeInterval(20, 30), 4,
        'https://dam.cocinafacil.com.mx/wp-content/uploads/2020/04/wan-tan.jpg'));
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
