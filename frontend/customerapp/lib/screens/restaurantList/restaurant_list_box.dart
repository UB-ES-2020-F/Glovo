import 'package:customerapp/models/logged.dart';
import 'package:customerapp/models/restaurants.dart';
import 'package:customerapp/models/user.dart';
import 'package:customerapp/styles/restaurant_list.dart';
import 'package:flutter/material.dart';
import 'package:icon_shadow/icon_shadow.dart';

class RestaurantsListCard extends StatefulWidget {
  final Restaurant restaurant;

  RestaurantsListCard(Key key, this.restaurant) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RestaurantsListCardState(key, restaurant);
  }
}

class RestaurantsListCardState extends State<StatefulWidget> {
  Restaurant restaurant;
  double elevation = 2;

  RestaurantsListCardState(Key key, this.restaurant);

  @override
  Widget build(BuildContext context) {
    User user = LoggedModel.user;
    double distance = restaurant.location.getDistanceKm(user.location);
    double deliveryFee = getDeliveryFee(distance);
    TimeInterval timeInterval = new TimeInterval.distance(distance);
    return Container(
        child: Card(
      elevation: this.elevation,
      child: Container(
          child: Column(
        children: [
          InkWell(
              onHover: (value) {
                if (value) {
                  setState(() {
                    elevation = 8;
                  });
                } else {
                  setState(() {
                    elevation = 2;
                  });
                }
              },
              onTap: () => loadProduct(context, restaurant),
              child: Container(
                alignment: Alignment.bottomCenter,
                height: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(restaurant.image),
                        fit: BoxFit.cover)),
                padding: EdgeInsets.only(bottom: 10, left: 0, right: 0, top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Container(
                              padding: EdgeInsets.only(right: 2.5, left: 15),
                              child: IconShadowWidget(
                                  Icon(
                                    Icons.watch_later,
                                    size: 22,
                                    color: Colors.white,
                                  ),
                                  shadowColor: Colors.black)),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 2.5),
                              child: Text(
                                '${timeInterval.min} - ${timeInterval.max} min',
                                style: restaurantListCardInsideImageText,
                              ))
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: IconShadowWidget(
                                  Icon(
                                    Icons.moped_rounded,
                                    size: 22,
                                    color: Colors.white,
                                  ),
                                  shadowColor: Colors.black)),
                          Container(
                              padding: EdgeInsets.only(left: 2.5, right: 15),
                              child: Text(
                                deliveryFee.toStringAsFixed(2) + ' €',
                                style: restaurantListCardInsideImageText,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            alignment: Alignment.centerLeft,
            child: InkWell(
                onTap: () => loadProduct(context, restaurant),
                child: Text(
                  restaurant.name,
                  style: restaurantListCardName,
                )),
          )
        ],
      )),
    ));
  }

  void loadProduct(BuildContext context, Restaurant restaurant) {
    Navigator.pushNamed(context, '/products', arguments: restaurant);
  }
}

class RestaurantsListCard_loc extends StatefulWidget {
  final RestaurantLoc restaurant;

  RestaurantsListCard_loc(Key key, this.restaurant) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RestaurantsListCardState_loc(key, restaurant);
  }
}

class RestaurantsListCardState_loc extends State<StatefulWidget> {
  RestaurantLoc restaurant;
  double elevation = 2;

  RestaurantsListCardState_loc(Key key, this.restaurant);

  @override
  Widget build(BuildContext context) {
    User user = LoggedModel.user;
    double distance = restaurant.distance;
    double deliveryFee = restaurant.deliveryFee;
    TimeInterval timeInterval = new TimeInterval.distance(distance);
    return Container(
        child: Card(
      elevation: this.elevation,
      child: Container(
          child: Column(
        children: [
          InkWell(
              onHover: (value) {
                if (value) {
                  setState(() {
                    elevation = 8;
                  });
                } else {
                  setState(() {
                    elevation = 2;
                  });
                }
              },
              onTap: () => loadProduct(context, restaurant),
              child: Container(
                alignment: Alignment.bottomCenter,
                height: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(restaurant.image),
                        fit: BoxFit.cover)),
                padding: EdgeInsets.only(bottom: 10, left: 0, right: 0, top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Container(
                              padding: EdgeInsets.only(right: 2.5, left: 15),
                              child: IconShadowWidget(
                                  Icon(
                                    Icons.watch_later,
                                    size: 22,
                                    color: Colors.white,
                                  ),
                                  shadowColor: Colors.black)),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 2.5),
                              child: Text(
                                '${timeInterval.min} - ${timeInterval.max} min',
                                style: restaurantListCardInsideImageText,
                              ))
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: IconShadowWidget(
                                  Icon(
                                    Icons.moped_rounded,
                                    size: 22,
                                    color: Colors.white,
                                  ),
                                  shadowColor: Colors.black)),
                          Container(
                              padding: EdgeInsets.only(left: 2.5, right: 15),
                              child: Text(
                                deliveryFee.toStringAsFixed(2) + ' €',
                                style: restaurantListCardInsideImageText,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            alignment: Alignment.centerLeft,
            child: InkWell(
                onTap: () => loadProduct(context, restaurant),
                child: Text(
              restaurant.name,
              style: restaurantListCardName,
            )),
          )
        ],
      )),
    ));
  }

  void loadProduct(BuildContext context, RestaurantLoc restaurant) {
    Navigator.pushNamed(context, '/products', arguments: restaurant);
  }
}
