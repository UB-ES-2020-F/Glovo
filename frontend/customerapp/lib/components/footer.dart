import 'dart:ui';

import 'package:customerapp/responsive/screen_responsive.dart';
import 'package:customerapp/screens/signUp/signup_dialog.dart';
import 'package:customerapp/screens/signIn/signin_dialog.dart';
import 'package:customerapp/styles/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:customerapp/styles/signup.dart';
import 'package:customerapp/screens/anon_bar.dart';

class Footer extends StatelessWidget {
  Color backgroundC;

  Footer(this.backgroundC);
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 1000) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomPaint(
            painter: ShapesPainter(),
            child: Container(height: 100),
          ),
          /*Container(
              height: 220,
              child: SampleAnimation(
                  MediaQuery.of(context).size.width, backgroundC)),*/
          Container(
              color: FooterBackgroundColor,
              height: 300,
              padding: EdgeInsets.only(bottom: 30, left: 20, right: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 800,
                        child: Expanded(
                            child: Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: [
                            TableRow(children: [
                              Padding(
                                  child: Row(
                                    children: [
                                      IconButton(
                                        iconSize: 30,
                                        icon: Image.asset(
                                          'resources/images/logo_kommet.png',
                                        ),
                                      ),
                                      Text(
                                        'Komet ',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).accentColor),
                                      )
                                    ],
                                  ),
                                  padding: EdgeInsets.only(bottom: 15)),
                              Text("JOIN US", style: FooterTextTitleStyle),
                              Text("HELP", style: FooterTextTitleStyle),
                              Text("LEGAL", style: FooterTextTitleStyle),
                              Text("FOLLOW US", style: FooterTextTitleStyle),
                            ]),
                            TableRow(children: [
                              Padding(
                                child: Text("About us",
                                    style: FooterTextNormalStyle),
                                padding: EdgeInsets.only(bottom: 15),
                              ),
                              Text("Careers", style: FooterTextNormalStyle),
                              Text("FAQ", style: FooterTextNormalStyle),
                              Text("Terms and conditions",
                                  style: FooterTextNormalStyle),
                              Text("Facebook", style: FooterTextNormalStyle),
                            ]),
                            TableRow(children: [
                              Padding(
                                child: Text("", style: FooterTextNormalStyle),
                                padding: EdgeInsets.only(bottom: 15),
                              ),
                              Text("Store Partners",
                                  style: FooterTextNormalStyle),
                              Text("Contact us", style: FooterTextNormalStyle),
                              Text("Privacy policy",
                                  style: FooterTextNormalStyle),
                              Text("Twitter", style: FooterTextNormalStyle),
                            ]),
                            TableRow(children: [
                              Padding(
                                child: Text("", style: FooterTextNormalStyle),
                                padding: EdgeInsets.only(bottom: 15),
                              ),
                              Text("Couriers", style: FooterTextNormalStyle),
                              Text("", style: FooterTextNormalStyle),
                              Text("Cookies Policy",
                                  style: FooterTextNormalStyle),
                              Text("Instagram", style: FooterTextNormalStyle),
                            ]),
                            TableRow(children: [
                              Padding(
                                child: Text("", style: FooterTextNormalStyle),
                                padding: EdgeInsets.only(bottom: 15),
                              ),
                              Text("Glovo business",
                                  style: FooterTextNormalStyle),
                              Text("", style: FooterTextNormalStyle),
                              Text("", style: FooterTextNormalStyle),
                              Text("", style: FooterTextNormalStyle),
                            ])
                          ],
                        ))),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.only(top: 2),
                              height: 70,
                              child: IconButton(
                                  iconSize: 120,
                                  icon: Image.asset(
                                    'resources/images/download-button.png',
                                  ))),
                          Container(
                              height: 70,
                              child: IconButton(
                                iconSize: 120,
                                icon: Image.asset(
                                  'resources/images/download-button_android.png',
                                ),
                              ))
                        ])
                  ]))
        ],
      );
    } else {
      return Container();
    }
  }
}

class ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Path();
    /*p.relativeQuadraticBezierTo(size.width/2, size.height/1.5, size.width, 0);
    p.moveTo(0, 0);
    p.lineTo(0, size.height);
    p.moveTo(0, size.height);
    p.lineTo(size.width, size.height);
    p.moveTo(size.width, size.height);
    p.lineTo(size.width, 0);*/
    /*p.moveTo(0.0, size.height);
    p.quadraticBezierTo(
        size.width / 2, size.height * 0.2, size.width, size.height);
    p.lineTo(size.width, 0.0);
    p.lineTo(0.0, 0.0);*/

    var paint = Paint();
    paint.color = FooterBackgroundColor;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, 0);
    path.quadraticBezierTo(
        size.width * 0.5, size.height * 2, size.width * 1.0, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class SampleAnimation extends StatefulWidget {
  double c;
  Color backC;
  SampleAnimation(this.c, this.backC);

  @override
  State<StatefulWidget> createState() {
    return SampleAnimationState(c, backC);
  }
}

class SampleAnimationState extends State<SampleAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  Path _path;
  double c;
  int size = 100;
  bool isfinished = false;
  Color backC;

  Image moto_dude_img = Image.asset(
    'resources/images/moto_dude.png',
  );

  SampleAnimationState(this.c, this.backC);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));

    _animation = Tween(begin: 0.0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {
          _path = drawPath();
        });
      });

    _controller.forward().whenComplete(() {
      isfinished = true;
    });
    _path = drawPath();
  }

  @override
  Widget build(BuildContext context) {
    c = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backC,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            child: CustomPaint(
              painter: PathPainter(drawPath_complete()),
            ),
          ),
          moto_dude(
              isfinished,
              calculate(_animation.value).dx,
              calculate(_animation.value).dy,
              calculate_angle(_animation.value).direction),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Path drawPath() {
    Size size = Size(c, 300);
    Path path = Path();
    path.moveTo(0, size.height / 10);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.8,
        size.width * 1.0, size.height / 10);

    return path;
  }

  Path drawPath_complete() {
    Size size = Size(c.toDouble(), 300);
    Path path = Path();
    path.moveTo(0, size.height / 3);
    path.quadraticBezierTo(
        size.width * 0.5, size.height, size.width * 1.0, size.height / 3);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  Offset calculate(value) {
    PathMetrics pathMetrics = _path.computeMetrics();
    PathMetric pathMetric = pathMetrics.elementAt(0);
    value = pathMetric.length * value;
    Tangent pos = pathMetric.getTangentForOffset(value);
    return pos.position;
  }

  Offset calculate_angle(value) {
    PathMetrics pathMetrics = _path.computeMetrics();
    PathMetric pathMetric = pathMetrics.elementAt(0);
    value = pathMetric.length * value;
    Tangent pos = pathMetric.getTangentForOffset(value);
    return pos.vector;
  }

  Widget moto_dude(bool finished, double posx, double posy, double angle) {
    if (!finished) {
      return Positioned(
          top: posy - 15,
          left: posx - 10,
          child: Transform.rotate(
            angle: angle,
            child: IconButton(iconSize: size.toDouble(), icon: moto_dude_img),
          ));
    } else {
      return Container();
    }
  }
}

class PathPainter extends CustomPainter {
  Path path;

  PathPainter(this.path);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = FooterBackgroundColor;
    paint.style = PaintingStyle.fill;

    canvas.drawPath(this.path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
