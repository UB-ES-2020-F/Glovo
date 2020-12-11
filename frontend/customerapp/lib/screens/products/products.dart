// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:customerapp/actions/check_login.dart';
import 'package:customerapp/components/appBar/default_logged_bar.dart';
import 'package:customerapp/components/footer.dart';
import 'package:customerapp/models/cart.dart';
import 'package:customerapp/models/products.dart';
import 'package:customerapp/models/restaurants.dart';
import 'package:customerapp/screens/commonComponents/single_message_dialog.dart';
import 'package:customerapp/screens/products/cart_box.dart';
import 'package:customerapp/styles/product.dart';
import 'package:customerapp/responsive/screen_responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:customerapp/endpoints/products.dart';

import 'cart_box.dart';
import 'product_card.dart';

class Products extends StatefulWidget {
  @override
  _Products createState() => _Products();
}

class _Products extends State<Products> {
  List prods = List();
  Cart cart;
  bool firstInstance;

  _Products() {
    firstInstance = true;
  }

  void addToCart(Product prod) {
    cart.addItem(prod);
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: userIsLogged(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              final Restaurant restaurant =
                  ModalRoute.of(context).settings.arguments;
              var productsModel = context.watch<ProductsListModel>();

              cart = context.watch<Cart>();
              if (firstInstance) {
                productsModel.removeProducts();
                cart.empty();
              }
              firstInstance = false;

              double cartWidth = 350;
              var s = BarResponsive(
                  context, '/overview-mobile', DefaultLoggedBar());
              var bar = s.getResponsiveBar();

              return Scaffold(
                  appBar: bar,
                  body: Stack(children: [
                    Container(
                        //padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                            color: Color(0xFFE0E0E0),
                            image: DecorationImage(
                                image: NetworkImage(
                                    restaurant == null ? '' : restaurant.image),
                                fit: BoxFit.fitWidth)),
                        child: Expanded(
                          child: SingleChildScrollView(
                              child: Column(children: [
                            Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: Container(
                                        padding: MediaQuery.of(context)
                                                    .size
                                                    .width <
                                                600
                                            ? EdgeInsets.fromLTRB(10, 30, 10, 0)
                                            : EdgeInsets.fromLTRB(
                                                30, 30, 30, 0),
                                        width:
                                            MediaQuery.of(context).size.width <=
                                                    900
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    40
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    cartWidth -
                                                    75,
                                        child: ListView(
                                            physics:
                                                NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                                            shrinkWrap: true,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 10),
                                                child: Container(
                                                  height: 140,
                                                  padding: EdgeInsets.fromLTRB(
                                                      40, 0, 40, 0),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                      color: Color(0xAAFFFFFF)),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    restaurant == null
                                                        ? 'Products'
                                                        : restaurant.name,
                                                    style: restaurantTitleStyle,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child:
                                                    Builder(builder: (builder) {
                                                  return FutureBuilder(
                                                    future:
                                                        getProductsFromRestaurant(
                                                            restaurant.id),
                                                    builder:
                                                        (BuildContext context,
                                                            AsyncSnapshot
                                                                snapshot2) {
                                                      if (snapshot2.hasData) {
                                                        productsModel
                                                            .removeProducts();
                                                        snapshot2.data
                                                            .forEach((element) {
                                                          productsModel
                                                              .addProduct(Product
                                                                  .fromDTO(
                                                                      element));
                                                        });
                                                        return StaggeredGridView
                                                            .countBuilder(
                                                          crossAxisSpacing: 10,
                                                          mainAxisSpacing: 10,
                                                          physics:
                                                              NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                                                          shrinkWrap: true,
                                                          itemCount: productsModel
                                                              .availableProducts
                                                              .length,
                                                          crossAxisCount:
                                                              MediaQuery.of(context)
                                                                          .size
                                                                          .width >
                                                                      600
                                                                  ? 2
                                                                  : 1,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return ProductListCard(
                                                                Key(
                                                                    'product-card-$index'),
                                                                productsModel
                                                                        .availableProducts[
                                                                    index],
                                                                addToCart);
                                                          },
                                                          staggeredTileBuilder:
                                                              (int index) =>
                                                                  StaggeredTile
                                                                      .fit(1),
                                                        );
                                                      } else {
                                                        return Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 0,
                                                                    0, 10),
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15.0),
                                                                  color: Color(
                                                                      0xAAFFFFFF)),
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child:
                                                                  CircularLoaderKomet(),
                                                            ));
                                                      }
                                                    },
                                                  );
                                                }),
                                              ),
                                            ]),
                                      )),
                                      if (MediaQuery.of(context).size.width >
                                          900)
                                        Column(
                                          children: [
                                            CartBox(restaurant, cartWidth, cart,
                                                prods)
                                          ],
                                        )
                                      else
                                        Container()
                                    ])),
                            Footer(Color(0x00000000))
                          ])),
                        )),
                    if (MediaQuery.of(context).size.width <= 900 &&
                        cart.order.isNotEmpty)
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: MakeOrderButton(
                              Key('cart-make-order-button'),
                              cart,
                              'Make order of ' +
                                  cart.countItems().toString() +
                                  ' items (' +
                                  cart.getTotalPrice().toStringAsFixed(2) +
                                  ' €)')),
                  ]));
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