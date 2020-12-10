import 'dart:ui';

import 'package:customerapp/models/products.dart';
import 'package:customerapp/screens/products/product_information.dart';
import 'package:flutter/material.dart';

class ProductDialog extends StatelessWidget {
  final Product product;
  final Function add;

  ProductDialog(this.product, this.add);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
        child: SimpleDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            children: [ProductInformation(product, add)]));
  }
}
