import 'package:customerapp/actions/extract-key-value.dart';
import 'package:customerapp/endpoints/cart.dart';
import 'package:customerapp/exceptions/order-callback-failed.dart';
import 'package:customerapp/models/cart.dart';
import 'package:customerapp/models/logged.dart';
import 'package:customerapp/models/products.dart';
import 'package:customerapp/models/restaurants.dart';
import 'package:customerapp/screens/commonComponents/single_message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:customerapp/styles/product.dart';

// ignore: must_be_immutable
class CartBox extends StatelessWidget {
  final double cartWidth;
  final RestaurantLoc restaurant;
  final Cart cart;
  final List prods;
  double distance;
  double deliveryFee;
  TimeInterval timeInterval;
  List<Widget> items;
  CartBox(this.restaurant, this.cartWidth, this.cart, this.prods);

  @override
  Widget build(BuildContext context) {
    distance = restaurant.distance;
    deliveryFee = restaurant.deliveryFee;
    timeInterval = new TimeInterval.distance(distance);
    items = new List<Widget>();
    var idx = 0;
    cart.order.forEach((key, value) {
      items.add(new ItemOnCart(Key('item-on-cart-$idx'), key, value, cart));
      idx++;
    });
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 30, 30, 30),
      child: Container(
        width: cartWidth,
        constraints: BoxConstraints(minHeight: 300),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
          border: Border.all(color: Colors.black12),
        ),
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Your Komet",
                  style: cartTitleStyle,
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(2, 0, 5, 0),
                      child: Icon(
                        Icons.watch_later_outlined,
                        size: 24,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '${timeInterval.min} - ${timeInterval.max} min',
                      style: cartTimeFeeStyle,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(22, 0, 5, 0),
                      child: Icon(
                        Icons.moped_outlined,
                        size: 24,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      deliveryFee.toStringAsFixed(2) + ' €',
                      style: cartTimeFeeStyle,
                    ),
                  ],
                )),
            if (cart.order.isNotEmpty)
              Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height - 421),
                  child: SingleChildScrollView(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    key: Key('cart-items'),
                    children: items,
                  )),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Products TOTAL',
                        style: cartTimeFeeStyle.copyWith(
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        cart.getTotalPrice().toStringAsFixed(2) + ' €',
                        style: totalPriceCartStyle,
                      ),
                    ],
                  ),
                ),
                MakeOrderButton(
                    Key('cart-make-order-button'), cart, 'Make order')
              ])
            else
              Container(
                key: Key('cart-items'),
                height: 0,
              )
          ],
        ),
      ),
    );
  }
}

class ItemOnCart extends StatelessWidget {
  final Cart cart;
  final Product prod;
  final int quantity;
  ItemOnCart(Key key, this.prod, this.quantity, this.cart) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      width: 50,
                      alignment: Alignment.centerRight,
                      child: Text(
                        quantity.toString() + 'x',
                        style: numberItemsCartStyle,
                      )),
                  Container(
                      width: 189,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        prod.name,
                        style: numberItemsCartStyle,
                      )),
                  Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      width: 84,
                      alignment: Alignment.centerRight,
                      child: Text(
                        (quantity * prod.price).toStringAsFixed(2) + ' €',
                        style: numberItemsCartStyle,
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    key: Key('${extractKeyValue(key)}-remove-button'),
                    icon: Icon(
                      Icons.remove,
                      color: Color(0xff43C1A4),
                    ),
                    onPressed: () {
                      cart.substractItem(prod);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Color(0xff43C1A4),
                    ),
                    onPressed: () {
                      cart.addItem(prod);
                    },
                  ),
                ],
              ),
              Divider(
                color: Colors.black,
                thickness: 0.3,
              ),
            ]));
  }
}

class MakeOrderButton extends StatelessWidget {
  final Cart cart;
  final String text;

  MakeOrderButton(Key key, this.cart, this.text) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Wrap(
        children: [
          ElevatedButton(
              onPressed: () {
                showLoaderDialog(context);
                final orderGeneration = cart.generateOrderDTO();
                orderGeneration.then((orderDTO) {
                  makeOrder(orderDTO).then((value) {
                    Navigator.pop(context);
                    showOrderDoneDialog(context);
                    cart.empty();
                  }).catchError((error, stackTrace) {
                    cart.empty();
                    print((error as OrderCallbackFailed).errorCode);
                    Navigator.pop(context);
                    showOrderFailedDialog(context);
                  });
                });
              },
              child: Text(text),
              style: makeOrderButtonStyle)
        ],
      ),
    );
  }
}

showOrderFailedDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => SingleMessageDialog("Order Failed"));
}

showOrderDoneDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => SingleMessageDialog("Order done!"));
}
