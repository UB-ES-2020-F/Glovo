import 'package:customerapp/components/appBar/default_logged_bar.dart';
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
        appBar: DefaultLoggedBar(),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'Restaurants',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Expanded(
                child: Container(
                  child: StaggeredGridView.countBuilder(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    itemCount: restaurantsModel.availableRestaurants.length,
                    crossAxisCount:
                        MediaQuery.of(context).size.width > 600 ? 2 : 1,
                    itemBuilder: (context, index) {
                      return RestaurantsListCard(
                          restaurantsModel.availableRestaurants[index]);
                    },
                    staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

create_restaurannt_cards(List<Restaurant> restaurants) {
  return restaurants
      .map((restaurant) => RestaurantsListCard(restaurant))
      .toList();
}
