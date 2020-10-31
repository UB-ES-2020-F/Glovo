import 'package:customerapp/models/product/product_overview.dart';
import 'package:customerapp/models/restaurants.dart';
import 'package:customerapp/screens/products/dialog_product.dart';
import 'package:customerapp/screens/signIn/signin_dialog.dart';
import 'package:customerapp/styles/restaurant_list.dart';
import 'package:flutter/material.dart';
import 'package:icon_shadow/icon_shadow.dart';

class Concrete_Product_Card extends StatelessWidget {
  Product_overview _product_overview;

  Concrete_Product_Card(this._product_overview);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: Card(
        child: Column(children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                image: DecorationImage(
                  image: NetworkImage(_product_overview.image),
                )),
            //'https://pngimg.com/uploads/pasta/pasta_PNG58.png',
          ),
          ListTile(
              title: Text(_product_overview.name),
              subtitle: Text(_product_overview.prod_description)),
          Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${_product_overview.price} Euros"),
                    IconButton(
                      icon: Icon(Icons.add),
                      iconSize: 30,
                      onPressed: MediaQuery.of(context).size.width > 600
                          ? () {
                              return showDialog(
                                  context: context,
                                  builder: (context) =>
                                      Dialog_product(_product_overview));
                            }
                          : () {
                              return Navigator.pushNamed(
                                  context, '/concrete_product',
                                  arguments: _product_overview);
                            }
                      /*() => showDialog(
                          context: context,
                          builder: (context) =>
                              Dialog_product(_product_overview))*/
                      ,
                    )
                  ]))
        ]),
      ),
    ));
  }
}
