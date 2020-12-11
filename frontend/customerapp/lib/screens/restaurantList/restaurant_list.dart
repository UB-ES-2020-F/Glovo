import 'dart:math';
import 'package:customerapp/actions/check_login.dart';
import 'package:customerapp/components/appBar/default_logged_bar.dart';

import 'package:customerapp/components/footer.dart';

import 'package:customerapp/endpoints/restaurants.dart';
import 'package:customerapp/models/logged.dart';
import 'package:customerapp/models/restaurants.dart';
import 'package:customerapp/models/update_model.dart';
import 'package:customerapp/responsive/screen_responsive.dart';
import 'package:customerapp/screens/commonComponents/single_message_dialog.dart';

import 'package:customerapp/screens/restaurantList/restaurant_list_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class RestaurantsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RestaurantsList();
}

class _RestaurantsList extends State<RestaurantsList> {
  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: userIsLogged(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              var restaurantsModel = context.watch<RestaurantsListModel>();
              var restaurantsModel2 = context.watch<RestaurantsListModel2>();

              Widget bar;
              var update;
              update = context.watch<Update_model>();

              var loggedmodel = context.watch<LoggedModel>();

              var s = BarResponsive(
                  context, '/overview-mobile', DefaultLoggedBar());
              bar = s.getResponsiveBar();

              print("estoy aqui");

              return Scaffold(
                  appBar: bar,
                  body: Container(
                      child: Center(
                    child: ListView(children: [
                      Container(height: MediaQuery.of(context).size.width / 50),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Restaurants',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      Builder(builder: (builder) {
                        return FutureBuilder(
                          future: getRestaurants(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              restaurantsModel.removeRestaurants();
                              snapshot.data.forEach((element) {
                                restaurantsModel
                                    .addRestaurant(Restaurant.fromDTO(element));
                              });
                              return StaggeredGridView.countBuilder(
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                physics:
                                    NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                                shrinkWrap: true,
                                itemCount: restaurantsModel
                                    .availableRestaurants.length,
                                crossAxisCount: max(
                                    MediaQuery.of(context).size.width ~/ 300.0,
                                    1),
                                itemBuilder: (context, index) {
                                  return RestaurantsListCard(
                                      Key('restaurant-card-$index'),
                                      restaurantsModel
                                          .availableRestaurants[index]);
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
                      /*Builder(builder: (builder) {
                        return FutureBuilder(
                          future: getRestaurantsLoc(
                              loggedmodel.getUser().location.latitude,
                              loggedmodel.getUser().location.longitude),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              restaurantsModel2.removeRestaurants();
                              snapshot.data.forEach((element) {
                                restaurantsModel2.addRestaurant(
                                    RestaurantLoc.fromDTO(element));
                              });
                              return StaggeredGridView.countBuilder(
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                physics:
                                    NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                                shrinkWrap: true,
                                itemCount: restaurantsModel
                                    .availableRestaurants.length,
                                crossAxisCount: max(
                                    MediaQuery.of(context).size.width ~/ 300.0,
                                    1),
                                itemBuilder: (context, index) {
                                  return RestaurantsListCard_loc(
                                      Key('restaurant-card2-$index'),
                                      restaurantsModel2
                                          .availableRestaurants[index]);
                                },
                                staggeredTileBuilder: (int index) =>
                                    StaggeredTile.fit(1),
                              );
                            } else {
                              return CircularLoaderKomet();
                            }
                          },
                        );
                      }),*/
                      Text(loggedmodel.getUser().location.latitude.toString()),
                      Footer(Color(0xffffffff)),
                    ]),
                  )));
            } else {
              Future.delayed(Duration.zero, () {
                Navigator.pushNamed(context, '/');
              });
              return CircularLoaderKomet();
              //
            }
          } else {
            return CircularLoaderKomet();
          }
        },
      );
}
