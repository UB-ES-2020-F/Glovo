import 'package:customerapp/components/appBar/default_logged_bar.dart';
import 'package:customerapp/models/product/mock_up_prod.dart';
import 'package:customerapp/models/restaurants.dart';
import 'package:customerapp/responsive/screen_responsive.dart';
import 'package:customerapp/screens/loggedPage/initial_logged_page.dart';
import 'package:customerapp/screens/loggedPage/logged_bar.dart';
import 'package:customerapp/screens/restaurantList/restaurant_list_box.dart';
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
    Widget bar;

    var s = Bar_responsive(context, '/overview_mobile', DefaultLoggedBar());
    bar = s.get_responsive_bar();

    return Scaffold(
        //backgroundColor: Theme.of(context).backgroundColor,
        appBar: bar,
        body: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Products',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Expanded(
                  child: Container(child: Center(child: Product_grid(prods)))),
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
      crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
      itemBuilder: (context, index) {
        return prods.asMap()[index];
      },
      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
    );
  }
}
