import 'package:customerapp/actions/check_login.dart';
import 'package:customerapp/components/footer.dart';
import 'package:customerapp/models/landingPageText.dart';
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
import 'package:customerapp/styles/signup.dart';
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
                backgroundColor: Colors.white,
                appBar: bar,
                body: Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Center(
                        child: Container(
                            padding: EdgeInsets.only(top: 10),
                            color: Theme.of(context).backgroundColor,
                            child: Center(
                              child: SingleChildScrollView(
                                  child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        minHeight:
                                            MediaQuery.of(context).size.height,
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
                                                  width: 300,
                                                  key: Key(
                                                      'initial-logged-in-komet-title-text'),
                                                ),
                                                Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            50, 30, 50, 0),
                                                    constraints: BoxConstraints(
                                                        maxWidth: 800),
                                                    child: FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        child: Text(
                                                          "Anything you want",
                                                          style: bigTextStyle,
                                                        ))),
                                                Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            80, 0, 80, 30),
                                                    constraints: BoxConstraints(
                                                        maxWidth: 800),
                                                    child: FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        child: Text(
                                                          "Delivered in minutes",
                                                          style: bigTextStyle
                                                              .copyWith(
                                                                  fontSize: 48),
                                                        ))),
                                                Container(
                                                    constraints: BoxConstraints(
                                                        maxHeight:
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height -
                                                                184),
                                                    padding: EdgeInsets.only(
                                                        left: 25, right: 25),
                                                    child:
                                                        SingleChildScrollView(
                                                            child: Wrap(
                                                                alignment:
                                                                    WrapAlignment
                                                                        .center,
                                                                children: [
                                                          FoodButton(Key(
                                                              "food-bubble-button")),
                                                          SupermarketsButton(Key(
                                                              "supermarket-bubble-button")),
                                                          SnacksButton(Key(
                                                              "snacks-bubble-button")),
                                                          AnythingButton(Key(
                                                              "anything-bubble-button")),
                                                          PharmacyButton(Key(
                                                              "pharmacy-button")),
                                                          DeliveryExpressButton(
                                                              Key("delivery-express-button")),
                                                          ShopsGiftsButton(Key(
                                                              "shops-gifts-button")),
                                                        ]))),
                                                Container(
                                                  height: 220,
                                                  child: WhiteZone(),
                                                ),
                                                if (MediaQuery.of(context)
                                                        .size
                                                        .width >
                                                    300)
                                                  AppAdZone(),
                                                WorkWithUs(),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Trending highlights in your town",
                          textAlign: TextAlign.center,
                          style: mediumTextStyle,
                        ))),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(50, 15, 50, 0),
                    child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Discover the stores in demand and have us deliver what you want on demand",
                          textAlign: TextAlign.center,
                          style: mediumSmallTextStyle,
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

// ignore: must_be_immutable
class AppAdZone extends StatelessWidget {
  double factor = 1;
  double factorFont = 1;
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 1000) {
      factor = 1.0;
      factorFont = 1.0;
    } else {
      factor = 0.5;
      factorFont = 0.65;
    }
    return Container(
        color: Colors.white,
        child: Stack(alignment: AlignmentDirectional.center, children: [
          Container(
            color: Colors.white,
            height: 400 * factor,
            width: MediaQuery.of(context).size.width,
            child: Positioned.fill(
              child: Image.asset(
                'resources/images/food_pattern.jpg',
                scale: 2.3,
                repeat: ImageRepeat.repeat,
              ),
            ),
          ),
          Container(
            height: 400 * factor,
            decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.8, 0.0),
                    colors: [
                      Color(0x66FFFFFF),
                      Theme.of(context).backgroundColor,
                    ],
                    stops: [
                      0.0,
                      1.0
                    ])),
          ),
          Container(
            //color: Colors.white,
            height: 500 * factor,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (MediaQuery.of(context).size.width > 570)
                  Image.asset(
                    'resources/images/app_image.png',
                    height: 500 * factor,
                  ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Follow your deliveries",
                      style:
                          mediumTextStyle.copyWith(fontSize: 40 * factorFont),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text(
                          "with the ",
                          style: mediumTextStyle.copyWith(
                              fontSize: 40 * factorFont),
                        ),
                        Text(
                          "Komet App",
                          style: mediumTextStyle.copyWith(
                              fontSize: 40 * factorFont,
                              color: Color(0xFF2ABB9B)),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(20 * factor),
                      constraints: BoxConstraints(maxWidth: 400 * factorFont),
                      child: Text(
                        "Watch the progress of your deliveries in real-time and order from anywhere",
                        textAlign: TextAlign.center,
                        style: mediumSmallTextStyle.copyWith(
                            color: Color(0xFF4A4A4A),
                            fontSize: 13 * factorFont + 5),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                            padding: EdgeInsets.only(top: 2),
                            height: 70,
                            child: IconButton(
                                onPressed: null,
                                iconSize: 200 * factorFont,
                                icon: Image.asset(
                                  'resources/images/download-button.png',
                                ))),
                        Container(
                            height: 70,
                            child: IconButton(
                              onPressed: null,
                              iconSize: 200 * factorFont,
                              icon: Image.asset(
                                'resources/images/download-button_android.png',
                              ),
                            ))
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ]));
  }
}

class WorkWithUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(50, 10, 50, 30),
              child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "We're building Komet together!",
                    textAlign: TextAlign.center,
                    style: mediumTextStyle,
                  ))),
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(50, 0, 50, 30),
              child: Wrap(
                  spacing: 30,
                  runSpacing: 30,
                  alignment: WrapAlignment.center,
                  children: [
                    WorkWithUsCards(
                      title: "Couriers",
                      subTitle: "Only the hours you want",
                      img: imgCouriers,
                      text: textCouriers,
                      buttonName: "Deliver with us",
                    ),
                    WorkWithUsCards(
                      title: "Store partners",
                      subTitle: "Multiply your sales",
                      img: imgPartners,
                      text: textPartners,
                      buttonName: "Partner with us",
                    ),
                    WorkWithUsCards(
                      title: "Careers",
                      subTitle: "Challenges to match your talent",
                      img: imgCareers,
                      text: textCareers,
                      buttonName: "Join the team",
                    )
                  ]))
        ]));
  }
}

// ignore: must_be_immutable
class WorkWithUsCards extends StatelessWidget {
  String title;
  String subTitle;
  String img;
  String text;
  String buttonName;

  WorkWithUsCards(
      {this.title, this.subTitle, this.img, this.text, this.buttonName});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      constraints: BoxConstraints(minHeight: 520),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.black26),
      ),
      child: Container(
          child: Column(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            height: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    image: NetworkImage(img), fit: BoxFit.cover)),
            padding: EdgeInsets.only(bottom: 10, left: 0, right: 0, top: 0),
          ),
          Container(
            constraints: BoxConstraints(minHeight: 270),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            alignment: Alignment.topCenter,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  title,
                                  textAlign: TextAlign.center,
                                  style: mediumTextStyle.copyWith(fontSize: 26),
                                ))),
                        Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  subTitle,
                                  textAlign: TextAlign.center,
                                  style: mediumSmallTextStyle,
                                ))),
                        Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Text(
                              text,
                              textAlign: TextAlign.justify,
                              style: smallTextStyle,
                            )),
                      ]),
                  Container(
                      padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                      child: Container(
                          width: 280,
                          height: 43,
                          alignment: Alignment.bottomCenter,
                          child: SizedBox.expand(
                            child: ElevatedButton(
                                onPressed: null,
                                child: Text(buttonName),
                                style: registerButtonStyle.copyWith(
                                    textStyle:
                                        MaterialStateProperty.resolveWith(
                                            (states) => TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700)))),
                          )))
                ]),
          )
        ],
      )),
    );
  }
}
