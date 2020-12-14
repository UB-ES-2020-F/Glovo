import 'package:customerapp/styles/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DeliveryExpressButton extends StatelessWidget {
  DeliveryExpressButton(Key key) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        width: 160,
        height: 160,
        child: SizedBox.expand(
            child: RaisedButton(
          onPressed: null,
          onLongPress: null,
          color: Colors.white,
          disabledColor: Colors.white,
          textColor: Colors.white,
          elevation: 4,
          disabledElevation: 4,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(
                    'resources/images/delivery_express_logo_gray.png'),
                height: 55,
                width: 55,
              ),
              Container(
                  padding: EdgeInsets.only(top: 5),
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Delivery Express',
                        style: categoryButtonLabel,
                        textAlign: TextAlign.center,
                      ))),
            ],
          ),
          padding: EdgeInsets.all(30),
          shape: CircleBorder(),
        )));
  }
}
