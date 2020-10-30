import 'package:customerapp/models/restaurants.dart';
import 'package:customerapp/styles/restaurant_list.dart';
import 'package:flutter/material.dart';
import 'package:icon_shadow/icon_shadow.dart';

class RestaurantsListCard extends StatelessWidget {
  Restaurant restaurant;
  RestaurantsListCard(this.restaurant);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
      child: Container(
          child: Column(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            height: 150,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(restaurant.image), fit: BoxFit.cover)),
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
                            '${restaurant.expectedDeliveryTime.min} - ${restaurant.expectedDeliveryTime.max} min',
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
                            '${restaurant.deliveryFee} €',
                            style: restaurantListCardInsideImageText,
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              alignment: Alignment.centerLeft,
              child: Text(
                restaurant.name,
                style: restaurantListCardName,
              )),
        ],
      )),
    ));
  }
}
