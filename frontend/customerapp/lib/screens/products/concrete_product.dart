import 'package:customerapp/models/product/product_overview.dart';
import 'package:flutter/material.dart';

class Concrete_Product extends StatelessWidget {
  Product_overview _product_overview;

  Concrete_Product(this._product_overview);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: Card(
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          ListTile(
              title: Text(_product_overview.name),
              subtitle: Text(_product_overview.prod_description)),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("3 euros"),
                        IconButton(
                          icon: Icon(Icons.add),
                          iconSize: 30,
                        )
                      ])))
        ]),
      ),
    ));
  }
}
