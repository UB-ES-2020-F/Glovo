import 'package:customerapp/components/appBar/default_logged_bar.dart';
import 'package:customerapp/components/appBar/mobile_default_bar.dart';
import 'package:customerapp/endpoints/restaurants.dart';
import 'package:customerapp/models/restaurants.dart';
import 'package:customerapp/responsive/screen_responsive.dart';
import 'package:customerapp/screens/loggedPage/initial_logged_page.dart';
import 'package:customerapp/screens/loggedPage/logged_bar.dart';
import 'package:customerapp/screens/restaurantList/restaurant_list_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class RestaurantsList extends StatelessWidget {
  bool queryMade = false;

  @override
  Widget build(BuildContext context) {
    var restaurantsModel = context.watch<RestaurantsListModel>();
    queryRestaurants(context, restaurantsModel);
    queryMade = true;

    Widget bar;

    var s = Bar_responsive(context, '/overview_mobile', DefaultLoggedBar());
    bar = s.get_responsive_bar();

    return Scaffold(
        appBar: bar,
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
                      return RestaurantsListCard(Key('restaurant-card-$index'),
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

void queryRestaurants(
    BuildContext context, RestaurantsListModel restaurantsListModel) {
  getRestaurants().then((restaurants) {
    restaurantsListModel.removeRestaurants();
    restaurants.forEach((element) {
      restaurantsListModel.addRestaurant(Restaurant.fromDTO(element));
    });
    restaurantsListModel.notifyListeners();
  }).catchError((error) {
    print(error);
  });
}
