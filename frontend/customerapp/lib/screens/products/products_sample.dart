import 'dart:js';

import 'package:customerapp/components/appBar/default_logged_bar.dart';
import 'package:customerapp/models/cart.dart';
import 'package:customerapp/models/product/mock_up_prod.dart';
import 'package:customerapp/models/restaurants.dart';
import 'package:customerapp/screens/loggedPage/initial_logged_page.dart';
import 'package:customerapp/screens/loggedPage/logged_bar.dart';
import 'package:customerapp/screens/products/cart_card.dart';
import 'package:customerapp/screens/restaurantList/restaurant_list_box.dart';
import 'package:customerapp/styles/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:customerapp/models/product/product_overview.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'concrete_product_card.dart';

class Products_sample extends StatelessWidget {
  List prods = List();

  Products_sample() {
    prods = Mock_up_prod().prod;
  }

  @override
  Widget build(BuildContext context) {
    final Restaurant restaurant = ModalRoute.of(context).settings.arguments;
    Cart cart = new Cart();
    cart.addItem(prods[0].product);
    double cartWidth = 350;
    return Scaffold(
        //backgroundColor: Theme.of(context).backgroundColor,
        appBar: DefaultLoggedBar(),
        body: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
                color: Colors.black38,
                image: DecorationImage(
                    image: NetworkImage(
                        restaurant == null ? '' : restaurant.image),
                    fit: BoxFit.fitWidth)),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(30, 30, 15, 0),
                    width: MediaQuery.of(context).size.width - cartWidth - 90,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Container(
                              height: 140,
                              padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Color(0xAAFFFFFF)),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                restaurant == null
                                    ? 'Products'
                                    : restaurant.name,
                                style: RestaurantTitleStyle,
                              ),
                            ),
                          ),
                          Expanded(
                              child: Container(
                                  child: Center(child: Product_grid(prods)))),
                        ]),
                  ),
                  Column(
                    children: [cartBox(restaurant, cartWidth, cart)],
                  )
                ])));
  }
}

class Product_grid extends StatelessWidget {
  List prods;
  Product_grid(this.prods);

  @override
  Widget build(BuildContext context) {
    var restaurantsModel = context.watch<RestaurantsListModel>();

    return StaggeredGridView.countBuilder(
      //padding: EdgeInsets.all(30),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      itemCount: prods.length,
      crossAxisCount: MediaQuery.of(context).size.width > 900 ? 2 : 1,
      itemBuilder: (context, index) {
        return prods.asMap()[index];
      },
      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
    );
  }
}
