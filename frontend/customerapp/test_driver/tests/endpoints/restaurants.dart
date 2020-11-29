import 'dart:collection';

import 'package:customerapp/dto/restaurant.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../actions/compute_distance.dart';
import '../../data/location.dart';
import '../../data/products.dart';
import '../../data/restaurants.dart';
import '../../dto/restaurants.dart';
import '../../endpointComponents/restaurants_endpoint.dart';

void main() {
  group('Restaurants endpoint tests', () {
    test(
        'it retrieves products of a given category of an existing restaurant when the category exists',
        () async {
      final order = await getRestaurantProductsOfCategory(
          validRestaurantId, validCategory);
      expect(order.products.length, greaterThan(1));
    });
    test(
        'it retrieves 0 products of a given category of an existing restaurant when the category does not exists',
        () async {
      bool categoryNotFound = false;
      try {
        await getRestaurantProductsOfCategory(
            validRestaurantId, invalidCategory);
      } catch (ex) {
        categoryNotFound = true;
      }
      expect(categoryNotFound, true);
    });
    test(
        'it retrieves the correct distances to restaurants to the given position',
        () async {
      final closestRestaurants =
          await getClosestRestaurants(valid_latitude, valid_longitude);
      final allRestaurants = await getAllRestaurants();
      final restaurantsAndDistancesToCurrent =
          getRestaurantsAndDistancesDictionary(allRestaurants);
      for (final restaurant in closestRestaurants.restaurants) {
        expect(
            (restaurant.distance -
                    restaurantsAndDistancesToCurrent[restaurant.id])
                .abs(),
            lessThan(
                50)); //Note that the distances implies errors due to precission of each system. //TODO, use the same computations
      }
    });

    test('it retrieves the closest restaurants to the given position ordered',
        () async {
      final closestRestaurants =
          await getClosestRestaurants(valid_latitude, valid_longitude);
      final allRestaurants = await getAllRestaurants();
      final restaurantsAndDistancesToCurrent =
          getRestaurantsAndDistances(allRestaurants);
      restaurantsAndDistancesToCurrent.sort((a, b) => a[1].compareTo(b[1]));
      final restaurantsIdsOrderedByDistance = restaurantsAndDistancesToCurrent
          .map((restaurantAndDistance) => restaurantAndDistance[0])
          .toList();
      final idsClosestRestaurants = closestRestaurants.restaurants
          .map((restaurant) => restaurant.id)
          .toList();
      expect(restaurantsIdsOrderedByDistance, idsClosestRestaurants);
    });
  });
}

List getRestaurantsAndDistances(RestaurantsDTO restaurants) {
  return restaurants.restaurants
      .map((restaurant) => [
            restaurant.id,
            computeDistance(restaurant.location.latitude,
                restaurant.location.longitude, valid_latitude, valid_longitude)
          ])
      .toList();
}

Map getRestaurantsAndDistancesDictionary(RestaurantsDTO restaurants) {
  Map restaurantsDistances = HashMap();
  for (final restaurant in restaurants.restaurants) {
    restaurantsDistances[restaurant.id] = computeDistance(
        restaurant.location.latitude,
        restaurant.location.longitude,
        valid_latitude,
        valid_longitude);
  }
  return restaurantsDistances;
}
