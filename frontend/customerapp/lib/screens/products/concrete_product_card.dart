import 'package:customerapp/models/product/product_overview.dart';
import 'package:customerapp/models/restaurants.dart';
import 'package:customerapp/screens/products/dialog_product.dart';
import 'package:customerapp/screens/signIn/signin_dialog.dart';
import 'package:customerapp/styles/product.dart';
import 'package:customerapp/styles/restaurant_list.dart';
import 'package:flutter/material.dart';
import 'package:icon_shadow/icon_shadow.dart';

class Concrete_Product_Card extends StatefulWidget {
  Product_overview _product_overview;

  Concrete_Product_Card(this._product_overview);

  @override
  State<StatefulWidget> createState() {
    return Widget_stateful_card(_product_overview);
  }
}

class Widget_stateful_card extends State<StatefulWidget> {
  Product_overview _product_overview;
  double elevation = 2;

  Widget_stateful_card(this._product_overview);

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: this.elevation,
        child: InkWell(
            onHover: (value) {
              if (value) {
                setState(() {
                  elevation = 8;
                });
              } else {
                setState(() {
                  elevation = 2;
                });
              }
            },
            onTap: () => change_product(),
            child: Center(
                child: Material(
                    elevation: this.elevation,
                    child: Container(
                      child: Card(
                        margin: EdgeInsets.zero,
                        //clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
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
                              title: Text(
                                _product_overview.name,
                                style: TitleStyleProduct,
                              ),
                              subtitle: Padding(
                                child: Text(_product_overview.prod_description),
                                padding: EdgeInsets.only(top: 7),
                              )),
                          Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("${_product_overview.price} €"),
                                    IconButton(
                                      icon: Icon(
                                        Icons.add,
                                        color: Color(0xff43C1A4),
                                      ),
                                      iconSize: 30,
                                      onPressed: () => change_product()
                                      /*() => showDialog(
                          context: context,
                          builder: (context) =>
                              Dialog_product(_product_overview))*/
                                      ,
                                    )
                                  ]))
                        ]),
                      ),
                    )))));
  }

  void change_product() {
    if (MediaQuery.of(context).size.width > 600) {
      showDialog(
          context: context,
          builder: (context) => Dialog_product(_product_overview));
    } else {
      Navigator.pushNamed(context, '/concrete_product',
          arguments: _product_overview);
    }
  }
}
