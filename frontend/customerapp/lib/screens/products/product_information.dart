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
    return Column(
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
        Text(product.name, style: registerToKometTextStyle),
        Padding(
          child: IntrinsicHeight(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 200,
                  width: 200,
                  padding: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      image: DecorationImage(
                          image: NetworkImage(
                        product.imgPath,
                      )))),
              Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 275,
                          child: Text(product.description,
                              style: DescriptionTextStyleProduct),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width - 275,
                            child: Text(product.price.toStringAsFixed(2) + " €",
                                style: PriceTextStyleProduct)),
                      ]))
            ],
          )),
          padding: EdgeInsets.all(30),
        ),
        Padding(
          child: ElevatedButton(
            onPressed: () {
              add(product);
              Navigator.pop(context);
            },
            child: Text("Add to your order"),
            style: greenButtonStyle,
          ),
          padding: EdgeInsets.all(20),
        )
      ],
    );
  }
}
