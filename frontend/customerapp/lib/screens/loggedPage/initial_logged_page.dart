import 'package:customerapp/actions/check_login.dart';
import 'package:customerapp/components/footer.dart';
import 'package:customerapp/responsive/screen_responsive.dart';
import 'package:customerapp/screens/commonComponents/anything_button.dart';
import 'package:customerapp/screens/commonComponents/delivery_express_button.dart';
import 'package:customerapp/screens/commonComponents/food_button.dart';
import 'package:customerapp/screens/commonComponents/pharmacy_button.dart';
import 'package:customerapp/screens/commonComponents/shops_gifts_button.dart';
import 'package:customerapp/screens/commonComponents/single_message_dialog.dart';
import 'package:customerapp/screens/commonComponents/snacks_button.dart';
import 'package:customerapp/screens/commonComponents/supermarkets_button.dart';
import 'package:customerapp/styles/initial_logged.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:customerapp/screens/loggedPage/logged_bar.dart';

class InitialLogged extends StatefulWidget {
  @override
  _InitialLogged createState() => _InitialLogged();
}

class _InitialLogged extends State<InitialLogged> {
  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: userIsLogged(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data) {
            Widget bar;

            var s = BarResponsive(
                context, '/overview-mobile', InitialLoggedBar(),
                mediumBar: InitialLoggedBarShort());
            bar = s.getResponsiveBar();

            return Scaffold(
                backgroundColor: Theme.of(context).backgroundColor,
                appBar: bar,
                body: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Center(
                        child: Container(
                            child: Center(
                      child: SingleChildScrollView(
                          child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: MediaQuery.of(context).size.height,
                              ),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          'resources/images/name_and_logo.png',
                                          width: 250,
                                          key: Key(
                                              'initial-logged-in-komet-title-text'),
                                        ),
                                        Container(
                                            padding: EdgeInsets.fromLTRB(
                                                50, 30, 50, 0),
                                            constraints:
                                                BoxConstraints(maxWidth: 800),
                                            child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  "Anything you want",
                                                  style: bigTextStyle,
                                                ))),
                                        Container(
                                            padding: EdgeInsets.fromLTRB(
                                                80, 0, 80, 30),
                                            constraints:
                                                BoxConstraints(maxWidth: 800),
                                            child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  "Delivered in minutes",
                                                  style: bigTextStyle.copyWith(
                                                      fontSize: 48),
                                                ))),
                                        Container(
                                            constraints: BoxConstraints(
                                                maxHeight:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height -
                                                        184),
                                            padding: EdgeInsets.only(
                                                left: 25, right: 25),
                                            child: SingleChildScrollView(
                                                child: Wrap(
                                                    alignment:
                                                        WrapAlignment.center,
                                                    children: [
                                                  FoodButton(Key(
                                                      "food-bubble-button")),
                                                  SupermarketsButton(Key(
                                                      "supermarket-bubble-button")),
                                                  SnacksButton(Key(
                                                      "snacks-bubble-button")),
                                                  AnythingButton(Key(
                                                      "anything-bubble-button")),
                                                  PharmacyButton(
                                                      Key("pharmacy-button")),
                                                  DeliveryExpressButton(Key(
                                                      "delivery-express-button")),
                                                  ShopsGiftsButton(Key(
                                                      "shops-gifts-button")),
                                                ]))),
                                        Container(
                                          height: 220,
                                          child: WhiteZone(),
                                        )
                                      ],
                                    ),
                                    Footer(Colors.white),
                                  ]))),
                    )))));
          } else {
            Future.delayed(Duration.zero, () {
              Navigator.pushNamed(context, '/');
            });
            return CircularLoaderKomet();
            //
          }
        } else {
          return CircularLoaderKomet();
        }
      });
}

class WhiteZone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      //backgroundColor: Colors.greenAccent,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: CustomPaint(
              painter: PathPainterInitial(
                  drawPathComplete(MediaQuery.of(context).size.width)),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.fromLTRB(50, 30, 50, 0),
                    //constraints: BoxConstraints(maxWidth: 800),
                    child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Trending highlights in your town",
                          style: mediumTextStyle,
                        ))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Path drawPathComplete(double width) {
    Size size = Size(width.toDouble(), 300);
    Path path = Path();
    path.moveTo(0, 2 * size.height / 3);
    path.quadraticBezierTo(
        size.width * 0.5, 0.0, size.width * 1.0, 2 * size.height / 3);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    return path;
  }
}

class PathPainterInitial extends CustomPainter {
  Path path;

  PathPainterInitial(this.path);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.white;
    //paint.color = Colors.blueAccent;
    paint.style = PaintingStyle.fill;

    canvas.drawPath(this.path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
