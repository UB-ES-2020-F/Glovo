import 'package:customerapp/models/restaurants.dart';
import 'package:customerapp/screens/restaurantList/restaurant_list_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class RestaurantsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var restaurantsModel = context.watch<RestaurantsListModel>();
    return Scaffold(
      body: StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        itemCount: restaurantsModel.availableRestaurants.length,
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
        itemBuilder: (context, index) {
          return RestaurantsListCard(
              restaurantsModel.availableRestaurants[index]);
        },
        staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
      ), //To delete
    );
  }
}

create_restaurant_cards(List<Restaurant> restaurants) {
  return restaurants
      .map((restaurant) => RestaurantsListCard(restaurant))
      .toList();
}
