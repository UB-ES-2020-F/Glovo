import 'package:customerapp/actions/extract-key-value.dart';
import 'package:customerapp/models/products.dart';
import 'package:customerapp/screens/products/product_dialog.dart';
import 'package:customerapp/styles/product.dart';
import 'package:flutter/material.dart';

class ProductListCard extends StatefulWidget {
  final Product _product;
  final Function add;

  ProductListCard(Key key, this._product, this.add) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProductListCardState(key, _product, add);
  }

  Product get product {
    return _product;
  }
}

class ProductListCardState extends State<StatefulWidget> {
  Key key;
  Product _product;
  Function add;
  double elevation = 2;

  ProductListCardState(this.key, this._product, this.add);

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
            onTap: () => changeProduct(add),
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
                                      image: NetworkImage(_product.imgPath),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          ListTile(
                              title: Text(
                                _product.name,
                                style: titleStyleProduct,
                              ),
                              subtitle: Padding(
                                child: Text(_product.description),
                                padding: EdgeInsets.only(top: 7),
                              )),
                          Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(_product.price.toStringAsFixed(2) +
                                        " €"),
                                    IconButton(
                                      key: Key(
                                          '${extractKeyValue(key)}-product-add-to-card'),
                                      icon: Icon(
                                        Icons.add,
                                        color: Color(0xff43C1A4),
                                      ),
                                      iconSize: 30,
                                      onPressed: () => add(_product),
                                    )
                                  ]))
                        ]),
                      ),
                    )))));
  }

  void changeProduct(Function add) {
    if (MediaQuery.of(context).size.width > 600) {
      showDialog(
          context: context, builder: (context) => ProductDialog(_product, add));
    } else {
      Navigator.pushNamed(context, '/concrete-product',
          arguments: ConcreteProductArguments(_product, add));
    }
  }
}

class ConcreteProductArguments {
  final Product prod;
  final Function add;
  ConcreteProductArguments(this.prod, this.add);
}
