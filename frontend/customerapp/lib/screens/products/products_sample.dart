import 'package:customerapp/components/appBar/default_logged_bar.dart';
import 'package:customerapp/models/product/mock_up_prod.dart';
import 'package:customerapp/models/restaurants.dart';
import 'package:customerapp/screens/loggedPage/initial_logged_page.dart';
import 'package:customerapp/screens/loggedPage/logged_bar.dart';
import 'package:customerapp/screens/restaurantList/restaurant_list_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:customerapp/models/product/product_overview.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'concrete_product.dart';

class Products_sample extends StatelessWidget {
  List prods = List();

  Products_sample() {
    prods = Mock_up_prod().prod;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Theme.of(context).backgroundColor,
        appBar: DefaultLoggedBar(),
        body: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    //alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      'Products',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  Expanded(
                      child: Container(
                          child: Center(
                              child: Product_grid(
                                  prods) /*GridView.count(
                      padding: EdgeInsets.all(20.0),
                      children: [for (var v in prods) v],
                      crossAxisCount: 4,
                      childAspectRatio: 0.8,*/
                              ))),
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
      padding: EdgeInsets.only(top: 30),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      itemCount: prods.length,
      crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
      itemBuilder: (context, index) {
        /*return RestaurantsListCard(Restaurant(
            1,
            'Tagliatella',
            TimeInterval(10, 20),
            2.5,
            'https://dam.cocinafacil.com.mx/wp-content/uploads/2020/04/dumplings.jpg'));*/
        return prods.asMap()[index];
      },
      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
    );
  }
}
