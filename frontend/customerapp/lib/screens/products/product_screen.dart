import 'package:customerapp/models/products.dart';
import 'package:customerapp/screens/products/product_card.dart';
import 'package:customerapp/screens/products/product_information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../restricted_page.dart';

class ProductScreen extends StatelessWidget {
  Product product;
  Function add;

  @override
  Widget build(BuildContext context) {
    return RestrictedPage(this._build(context));
  }

  Widget _build(BuildContext context) {
    final ConcreteProductArguments args =
        ModalRoute.of(context).settings.arguments;
    this.product = args.prod;
    this.add = args.add;

    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: ProductInformation(product, add)));
  }
}
