import 'package:customerapp/models/products.dart';
import 'package:customerapp/screens/commonComponents/single_message_dialog.dart';
import 'package:customerapp/screens/products/product_card.dart';
import 'package:customerapp/screens/products/product_information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../restricted_page.dart';

class ProductScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductScreen();
}

class _ProductScreen extends State<ProductScreen> {
  Product product;
  Function add;
  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: userIsLogged(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              final ConcreteProductArguments args =
                  ModalRoute.of(context).settings.arguments;
              this.product = args.prod;
              this.add = args.add;

              return Scaffold(
                  body: Container(
                      alignment: Alignment.center,
                      child: ProductInformation(product, add)));
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
