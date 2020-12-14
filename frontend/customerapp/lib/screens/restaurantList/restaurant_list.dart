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
import 'package:customerapp/styles/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class RestaurantsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RestaurantsList();
}

class _RestaurantsList extends State<RestaurantsList> {
  /*Stream<List<RestaurantFeeDTO>> Function(LoggedModel l) _bids = (LoggedModel l) async* {
  await Future<void>.delayed(Duration(seconds: 1));
  yield await getRestaurantsLoc(
                              l.getUserAndNotify().location.latitude,
                              l.getUserAndNotify().location.longitude);
};*/

  RestaurantsListModelFee auxModel;

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: userIsLogged(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              var restaurantsModelFee =
                  context.watch<RestaurantsListModelFee>();
              var update = context.watch<UpdateModel>();
              Widget bar;
              var loggedmodel = context.watch<LoggedModel>();
              var s = BarResponsive(
                  context, '/overview-mobile', DefaultLoggedBar());
              bar = s.getResponsiveBar();

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
                      update.updateRestaurants
                          ? Builder(builder: (builder) {
                              return FutureBuilder(
                                future: getRestaurantsLoc(
                                    loggedmodel
                                        .getUserAndNotify()
                                        .location
                                        .latitude,
                                    loggedmodel
                                        .getUserAndNotify()
                                        .location
                                        .longitude),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasData) {
                                      restaurantsModelFee.removeRestaurants();
                                      snapshot.data.forEach((element) {
                                        restaurantsModelFee.addRestaurant(
                                            RestaurantLoc.fromDTO(element));
                                      });
                                      auxModel = restaurantsModelFee;
                                      return StaggeredGridView.countBuilder(
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        physics:
                                            NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                                        shrinkWrap: true,
                                        itemCount: restaurantsModelFee
                                            .availableRestaurants.length,
                                        crossAxisCount: max(
                                            MediaQuery.of(context).size.width ~/
                                                300.0,
                                            1),
                                        itemBuilder: (context, index) {
                                          return RestaurantsListCardLoc(
                                              Key('restaurant-card-$index'),
                                              restaurantsModelFee
                                                  .availableRestaurants[index]);
                                        },
                                        staggeredTileBuilder: (int index) =>
                                            StaggeredTile.fit(1),
                                      );
                                    } else {
                                      return CircularLoaderKomet();
                                    }
                                  } else {
                                    return CircularLoaderKomet();
                                  }
                                },
                              );
                            })
                          : Builder(builder: (builder) {
                              return FutureBuilder(
                                future: getRestaurantsLoc(
                                    loggedmodel
                                        .getUserAndNotify()
                                        .location
                                        .latitude,
                                    loggedmodel
                                        .getUserAndNotify()
                                        .location
                                        .longitude),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    restaurantsModelFee.removeRestaurants();
                                    snapshot.data.forEach((element) {
                                      restaurantsModelFee.addRestaurant(
                                          RestaurantLoc.fromDTO(element));
                                    });
                                    return StaggeredGridView.countBuilder(
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      physics:
                                          NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                                      shrinkWrap: true,
                                      itemCount: restaurantsModelFee
                                          .availableRestaurants.length,
                                      crossAxisCount: max(
                                          MediaQuery.of(context).size.width ~/
                                              300.0,
                                          1),
                                      itemBuilder: (context, index) {
                                        return RestaurantsListCardLoc(
                                            Key('restaurant-card-$index'),
                                            restaurantsModelFee
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

                      /*StreamBuilder<List<RestaurantFeeDTO>>(
                          stream: _bids(loggedmodel),
                          builder: (BuildContext context, AsyncSnapshot<List<RestaurantFeeDTO>> snapshot) {
                                              if (snapshot.hasData) {
                                                return Container();
                                                
                                              }
                                              else{
                                                return Text("dsd");
                                                //return CircularLoaderKomet();
                                              }
                                              
                                      
                          })*/

                      Footer(defaultAppBarBackgroundColor),
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
