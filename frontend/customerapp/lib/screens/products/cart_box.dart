import 'package:customerapp/models/cart.dart';
import 'package:customerapp/models/logged.dart';
import 'package:customerapp/models/product/product_overview.dart';
import 'package:customerapp/models/restaurants.dart';
import 'package:customerapp/models/user.dart';
import 'package:customerapp/styles/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:customerapp/styles/product.dart';
import 'package:provider/provider.dart';

class CartBox extends StatelessWidget {
  double cartWidth;
  Restaurant restaurant;
  Cart cart;
  List prods;
  double distance;
  double deliveryFee;
  TimeInterval timeInterval;
  List<Widget> items;
  CartBox(this.restaurant, this.cartWidth, this.cart, this.prods);

  @override
  Widget build(BuildContext context) {
    //var signInModel = context.watch<Cart>();
    distance = restaurant == null
        ? null
        : restaurant.location.getDistanceKm(LoggedModel.user.location);
    deliveryFee = getDeliveryFee(distance);
    timeInterval = new TimeInterval.distance(distance);
    items = new List<Widget>();
    cart.order.forEach((key, value) {
      items.add(new ItemOnCart(key, value, cart));
    });
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 30, 30, 30),
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
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Your Komet",
                  style: CartTitleStyle,
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
                      style: CartTimeFeeStyle,
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
                      '$deliveryFee €',
                      style: CartTimeFeeStyle,
                    ),
                  ],
                )),
            if (cart.order.isNotEmpty)
              Column(children: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: items,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Products TOTAL',
                        style: NumberItemsCartStyle,
                      ),
                      Text(
                        cart.getTotalPrice().toString() + ' €',
                        style: TotalPriceCartStyle,
                      ),
                    ],
                  ),
                ),
                MakeOrderButton(cart)
              ])
            else
              Container(
                height: 0,
              )
          ],
        ),
      ),
    );
  }
}

class ItemOnCart extends StatelessWidget {
  Cart cart;
  Product_overview prod;
  int quantity;
  ItemOnCart(this.prod, this.quantity, this.cart);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  width: 48,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    quantity.toString() + 'x',
                    style: NumberItemsCartStyle,
                  )),
              Container(
                  width: 200,
                  child: Text(
                    prod.name,
                    style: CartTimeFeeStyle,
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  width: 60,
                  alignment: Alignment.centerRight,
                  child: Text(
                    (quantity * prod.price).toString() + ' €',
                    style: CartTimeFeeStyle,
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
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
        ]);
  }
}

class MakeOrderButton extends StatelessWidget {
  Cart cart;

  MakeOrderButton(this.cart);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Wrap(
        children: [
          ElevatedButton(
              onPressed: () {
                cart.empty();
                showDialog(
                    context: context, builder: (context) => OrderDoneDialog());
              },
              child: Text('Make order'),
              style: makeOrderButtonStyle)
        ],
      ),
    );
  }
}

class OrderDoneDialog extends StatelessWidget {
  OrderDoneDialog();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              Text(
                'Order done!',
                style: CartTitleStyle,
              ),
              Padding(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Okay"),
                  style: greenButtonStyle,
                ),
                padding: EdgeInsets.all(20),
              )
            ],
          )
        ]);
  }
}
