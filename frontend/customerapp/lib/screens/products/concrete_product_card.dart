import 'package:customerapp/actions/extract-key-value.dart';
import 'package:customerapp/models/products.dart';
import 'package:customerapp/screens/products/dialog_product.dart';
import 'package:customerapp/styles/product.dart';
import 'package:flutter/material.dart';

class Concrete_Product_Card extends StatefulWidget {
  Product _product_overview;
  Function add;

  Concrete_Product_Card(Key key, this._product_overview, this.add)
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return Widget_stateful_card(key, _product_overview, add);
  }

  Product get product {
    return _product_overview;
  }
}

class Widget_stateful_card extends State<StatefulWidget> {
  Key key;
  Product _product_overview;
  Function add;
  double elevation = 2;

  Widget_stateful_card(this.key, this._product_overview, this.add);

  @override
  Widget build(BuildContext context) {
    return Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
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
            onTap: () => change_product(add),
            child: Center(
                child: Material(
                    elevation: this.elevation,
                    child: Container(
                      child: Card(
                        margin: EdgeInsets.zero,
                        //clipBehavior: Clip.antiAlias,
                        child: Column(children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(color: Colors.black26),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          _product_overview.imgPath),
                                      fit: BoxFit.cover)),
                              //'https://pngimg.com/uploads/pasta/pasta_PNG58.png',
                            ),
                          ),
                          ListTile(
                              title: Text(
                                _product_overview.name,
                                style: TitleStyleProduct,
                              ),
                              subtitle: Padding(
                                child: Text(_product_overview.description),
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
                                      key: Key(
                                          '${extractKeyValue(key)}-product-add-to-card'),
                                      icon: Icon(
                                        Icons.add,
                                        color: Color(0xff43C1A4),
                                      ),
                                      iconSize: 30,
                                      onPressed: () => add(_product_overview)
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

  void change_product(Function add) {
    if (MediaQuery.of(context).size.width > 600) {
      showDialog(
          context: context,
          builder: (context) => Dialog_product(_product_overview, add));
    } else {
      Navigator.pushNamed(context, '/concrete_product',
          arguments: ConcreteProductArguments(_product_overview, add));
    }
  }
}

class ConcreteProductArguments {
  final Product prod;
  final Function add;
  ConcreteProductArguments(this.prod, this.add);
}
