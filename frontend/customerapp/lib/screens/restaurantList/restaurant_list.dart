import 'dart:math';
import 'package:customerapp/components/appBar/default_logged_bar.dart';
import 'package:customerapp/endpoints/restaurants.dart';
import 'package:customerapp/models/restaurants.dart';
import 'package:customerapp/responsive/screen_responsive.dart';
import 'package:customerapp/screens/commonComponents/single_message_dialog.dart';
import 'package:customerapp/screens/restaurantList/restaurant_list_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../restricted_page.dart';

class RestaurantsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RestrictedPage(this._build(context));
  }

  Widget _build(BuildContext context) {
    var restaurantsModel = context.watch<RestaurantsListModel>();

    Widget bar;

    var s = Bar_responsive(context, '/overview-mobile', DefaultLoggedBar());
    bar = s.get_responsive_bar();

    return Scaffold(
        appBar: bar,
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(height: MediaQuery.of(context).size.width / 1000000),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'Restaurants',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Expanded(
                child: Builder(builder: (builder) {
                  return FutureBuilder(
                    future: getRestaurants(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        restaurantsModel.removeRestaurants();
                        snapshot.data.forEach((element) {
                          restaurantsModel
                              .addRestaurant(Restaurant.fromDTO(element));
                        });
                        return StaggeredGridView.countBuilder(
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          itemCount:
                              restaurantsModel.availableRestaurants.length,
                          crossAxisCount: max(
                              MediaQuery.of(context).size.width ~/ 300.0, 1),
                          itemBuilder: (context, index) {
                            return RestaurantsListCard(
                                Key('restaurant-card-$index'),
                                restaurantsModel.availableRestaurants[index]);
                          },
                          staggeredTileBuilder: (int index) =>
                              StaggeredTile.fit(1),
                        );
                      } else {
                        return CircularLoaderKomet();
                      }
                    },
                  );
                }),
              )
            ],
          ),
        ));
  }
}
