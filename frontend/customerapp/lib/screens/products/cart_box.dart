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

  @override
  Widget build(BuildContext context) {
    distance = widget.restaurant == null
        ? 5.0
        : widget.restaurant.location.getDistanceKm(LoggedModel.user.location);
    deliveryFee = getDeliveryFee(distance);
    timeInterval = new TimeInterval.distance(distance);
    items = new List<Widget>();
    widget.cart.order.forEach((key, value) {
      items.add(new Text(value.toString() +
          'x ' +
          key.name +
          ' ' +
          key.price.toString() +
          ' €'));
    });
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 30, 30, 30),
      child: Container(
        width: widget.cartWidth,
        constraints: BoxConstraints(maxHeight: 300),
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
            IconButton(
              icon: Icon(
                Icons.add,
                color: Color(0xff43C1A4),
              ),
              onPressed: () {
                setState(() {
                  widget.cart.addItem(widget.prods[0]);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
