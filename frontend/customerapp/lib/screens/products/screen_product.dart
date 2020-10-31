import 'package:customerapp/models/product/product_overview.dart';
import 'package:customerapp/styles/product.dart';
import 'package:customerapp/styles/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Screen_product extends StatelessWidget {
  Product_overview product;

  Screen_product();

  @override
  Widget build(BuildContext context) {
    final Product_overview prod = ModalRoute.of(context).settings.arguments;
    this.product = prod;

    return Scaffold(
        body: Container(
      child: Column(
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
          /*Container(
                  padding: EdgeInsets.all(220),
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage(
                        "https://t1.rg.ltmcdn.com/es/images/9/1/0/macarrones_con_pollo_faciles_y_deliciosos_71019_orig.jpg"),
                  ))),*/
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
                            //fit: BoxFit.fitWidth,
                            image: NetworkImage(
                          product.image,
                        )))),
                Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(product.prod_description,
                              style: DescriptionTextStyleProduct),
                          Text("${product.price} euros",
                              style: PriceTextStyleProduct)
                        ]))
              ],
            )),
            padding: EdgeInsets.all(30),
          ),
          Padding(
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Add to your order"),
              style: greenButtonStyle,
            ),
            padding: EdgeInsets.all(20),
          )
        ],
      ),
    ));
  }
}
