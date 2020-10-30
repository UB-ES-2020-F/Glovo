import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:customerapp/models/product/product_overview.dart';

import 'concrete_product.dart';

class Products_sample extends StatelessWidget {
  List prods = List();

  Products_sample() {
    prods.add(
        Concrete_Product(Product_overview("Macarrons", "a la italiana", 12)));
    prods.add(
        Concrete_Product(Product_overview("Tortellini", "a la italiana", 12)));
    prods.add(
        Concrete_Product(Product_overview("Ravioli", "a la italiana", 12)));
    prods.add(
        Concrete_Product(Product_overview("Macarrons", "a la italiana", 12)));
    prods.add(
        Concrete_Product(Product_overview("Tortellini", "a la italiana", 12)));
    prods.add(
        Concrete_Product(Product_overview("Ravioli", "a la italiana", 12)));
    prods.add(
        Concrete_Product(Product_overview("Macarrons", "a la italiana", 12)));
    prods.add(
        Concrete_Product(Product_overview("Tortellini", "a la italiana", 12)));
    prods.add(
        Concrete_Product(Product_overview("Ravioli", "a la italiana", 12)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Center(
          child: Container(
              child: Center(
                  child: GridView.count(
            padding: EdgeInsets.all(20.0),
            children: [for (var v in prods) v],
            crossAxisCount: 3,
            childAspectRatio: 2,
          ))),
        ));
  }
}
