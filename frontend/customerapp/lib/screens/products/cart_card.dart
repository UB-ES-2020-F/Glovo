import 'package:customerapp/models/cart.dart';
import 'package:customerapp/models/logged.dart';
import 'package:customerapp/models/restaurants.dart';
import 'package:customerapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:customerapp/styles/product.dart';

class cartBox extends StatelessWidget {
  double cartWidth;
  Restaurant restaurant;
  Cart cart;
  cartBox(this.restaurant, this.cartWidth, this.cart);
  @override
  Widget build(BuildContext context) {
    double distance = restaurant == null
        ? 5.0
        : restaurant.location.getDistanceKm(LoggedModel.user.location);
    double deliveryFee = getDeliveryFee(distance);
    TimeInterval timeInterval = new TimeInterval.distance(distance);
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 30, 30, 30),
      child: Container(
        width: cartWidth,
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
              child: ProductsListCart(cart),
            )
          ],
        ),
      ),
    );
  }
}

class ProductsListCart extends StatelessWidget {
  Cart _cart;
  ProductsListCart(this._cart);
  String items = '';
  @override
  Widget build(BuildContext context) {
    _cart.order.forEach((key, value) {
      items += value.toString();
      items += 'x ' + key.name;
    });

    return Text(items);
  }
}
