import 'package:customerapp/models/cart.dart';
import 'package:customerapp/models/logged.dart';
import 'package:customerapp/models/product/product_overview.dart';
import 'package:customerapp/models/restaurants.dart';
import 'package:customerapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:customerapp/styles/product.dart';

class CartBox extends StatefulWidget {
  double cartWidth;
  Restaurant restaurant;
  Cart cart;
  List prods;
  CartBox(this.restaurant, this.cartWidth, this.cart, this.prods);

  @override
  State<StatefulWidget> createState() => _CartBoxState();
}

class _CartBoxState extends State<CartBox> {
  double distance;
  double deliveryFee;
  TimeInterval timeInterval;
  List<Widget> items;

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    distance = widget.restaurant == null
        ? 5.0
        : widget.restaurant.location.getDistanceKm(LoggedModel.user.location);
    deliveryFee = getDeliveryFee(distance);
    timeInterval = new TimeInterval.distance(distance);
    items = new List<Widget>();
    widget.cart.order.forEach((key, value) {
      items.add(new ItemOnCart(key, value, widget.cart, refresh));
    });
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 30, 30, 30),
      child: Container(
        width: widget.cartWidth,
        constraints: BoxConstraints(minHeight: 300),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
          border: Border.all(color: Colors.black12),
        ),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Your komet",
                  style: CartTitleStyle,
                )),
            Padding(
                padding: EdgeInsets.all(5),
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
                      '$deliveryFee€',
                      style: CartTimeFeeStyle,
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                children: items,
              ),
            ),
            Text('Total price: ' +
                widget.cart.getTotalPrice().toString() +
                ' €'),
            MakeOrderButton(widget.cart, refresh)
          ],
        ),
      ),
    );
  }
}

class ItemOnCart extends StatefulWidget {
  Function refresh;
  Cart cart;
  Product_overview prod;
  int quantity;
  ItemOnCart(this.prod, this.quantity, this.cart, this.refresh);

  @override
  State<StatefulWidget> createState() => _ItemOnCartState();
}

class _ItemOnCartState extends State<ItemOnCart> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(widget.quantity.toString() +
          'x ' +
          widget.prod.name +
          ' ' +
          widget.prod.price.toString() +
          ' €'),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Color(0xff43C1A4),
            ),
            onPressed: () {
              setState(() {
                widget.cart.addItem(widget.prod);
                widget.refresh();
              });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.remove,
              color: Color(0xff43C1A4),
            ),
            onPressed: () {
              setState(() {
                widget.cart.substractItem(widget.prod);
                widget.refresh();
              });
            },
          )
        ],
      )
    ]);
  }
}

class MakeOrderButton extends StatelessWidget {
  Cart cart;
  Function refresh;

  MakeOrderButton(this.cart, this.refresh);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Wrap(
        children: [
          ElevatedButton(
              onPressed: () {
                cart.empty();
                refresh();
              },
              child: Text('Make the order'),
              style: makeOrderButtonStyle)
        ],
      ),
    );
  }
}
