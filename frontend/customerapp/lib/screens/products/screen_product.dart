import 'package:customerapp/models/product/product_overview.dart';
import 'package:customerapp/screens/products/concrete_product_card.dart';
import 'package:customerapp/styles/product.dart';
import 'package:customerapp/styles/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Screen_products extends StatelessWidget {
  Product_overview product;
  Function add;

  Screen_products();

  @override
  Widget build(BuildContext context) {
    final ConcreteProductArguments args =
        ModalRoute.of(context).settings.arguments;
    this.product = args.prod;
    this.add = args.add;

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
                          product.imgPath,
                        )))),
                Padding(
                    padding: EdgeInsets.only(left: 15),
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
                              child: Text("${product.price} euros",
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
      ),
    ));
  }
}
