import 'dart:math';
import 'dart:ui';

import 'package:customerapp/models/products.dart';
import 'package:customerapp/styles/product.dart';
import 'package:customerapp/styles/signup.dart';
import 'package:flutter/material.dart';

class ProductInformation extends StatelessWidget {
  Product product;
  Function add;

  ProductInformation(this.product, this.add);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment(1, 1),
                child: IconButton(
                  color: Color(0xFF6E6E6E),
                  icon: Icon(Icons.clear),
                  iconSize: 40,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )),
            Text(
              product.name,
              style: registerToKometTextStyle,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: IntrinsicHeight(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: min(
                          MediaQuery.of(context).size.width / 2.0 - 60, 200.0),
                      width: min(
                          MediaQuery.of(context).size.width / 2.0 - 60, 200.0),
                      padding: EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          image: DecorationImage(
                              image: NetworkImage(
                            product.imgPath,
                          )))),
                  Container(
                      width: min(
                          MediaQuery.of(context).size.width / 2.0 - 60, 300.0),
                      padding: EdgeInsets.only(left: 15),
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.description,
                              style: DescriptionTextStyleProduct,
                              textAlign: TextAlign.justify,
                            ),
                            Text(product.price.toStringAsFixed(2) + " €",
                                style: PriceTextStyleProduct),
                          ]))
                ],
              )),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  add(product);
                  Navigator.pop(context);
                },
                child: Text("Add to your order"),
                style: greenButtonStyle,
              ),
            )
          ],
        ));
  }
}
