import 'dart:ui';

import 'package:customerapp/components/appBar/default_logged_bar.dart';
import 'package:customerapp/components/text_link.dart';
import 'package:customerapp/styles/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class Footer extends StatelessWidget {
  Color backgroundC;
  final scrollController = ScrollController();

  Footer(this.backgroundC);
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 100) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              height: 220,
              child: SampleAnimation(
                  MediaQuery.of(context).size.width, backgroundC)),
          Container(
              color: footerBackgroundColor,
              alignment: Alignment.center,
              height: 300,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Scrollbar(
                  isAlwaysShown: true,
                  controller: scrollController,
                  child: SingleChildScrollView(
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: 800,
                                child: Table(
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.baseline,
                                  children: [
                                    TableRow(children: [
                                      Container(
                                          child: LogoGray(),
                                          transform: Matrix4.translationValues(
                                              -15.0, -20.0, 0.0),
                                          padding: EdgeInsets.only(left: 0)),
                                      Container(
                                          transform: Matrix4.translationValues(
                                              0.0, 30.0, 0.0),
                                          child: Text("JOIN US",
                                              style: footerTextTitleStyle)),
                                      Container(
                                          transform: Matrix4.translationValues(
                                              0.0, 30.0, 0.0),
                                          child: Text("HELP",
                                              style: footerTextTitleStyle)),
                                      Container(
                                          transform: Matrix4.translationValues(
                                              0.0, 30.0, 0.0),
                                          child: Text("LEGAL",
                                              style: footerTextTitleStyle)),
                                      Container(
                                          transform: Matrix4.translationValues(
                                              0.0, 30.0, 0.0),
                                          child: Text("FOLLOW US",
                                              style: footerTextTitleStyle)),
                                    ]),
                                    TableRow(children: [
                                      Padding(
                                        child: TextLink('About us', (context) {
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  '/about-us',
                                                  (route) => false);
                                        }, footerTextNormalStyle,
                                            footerTextNormalStyle, context),
                                        padding: EdgeInsets.only(bottom: 15),
                                      ),
                                      Text("Careers",
                                          style: footerTextNormalStyle),
                                      Text("FAQ", style: footerTextNormalStyle),
                                      Text("Terms and conditions",
                                          style: footerTextNormalStyle),
                                      Text("Facebook",
                                          style: footerTextNormalStyle),
                                    ]),
                                    TableRow(children: [
                                      Padding(
                                        child: Text("",
                                            style: footerTextNormalStyle),
                                        padding: EdgeInsets.only(bottom: 15),
                                      ),
                                      Text("Store Partners",
                                          style: footerTextNormalStyle),
                                      Text("Contact us",
                                          style: footerTextNormalStyle),
                                      Text("Privacy policy",
                                          style: footerTextNormalStyle),
                                      Text("Twitter",
                                          style: footerTextNormalStyle),
                                    ]),
                                    TableRow(children: [
                                      Padding(
                                        child: Text("",
                                            style: footerTextNormalStyle),
                                        padding: EdgeInsets.only(bottom: 15),
                                      ),
                                      Text("Couriers",
                                          style: footerTextNormalStyle),
                                      Text("", style: footerTextNormalStyle),
                                      Text("Cookies Policy",
                                          style: footerTextNormalStyle),
                                      Text("Instagram",
                                          style: footerTextNormalStyle),
                                    ]),
                                    TableRow(children: [
                                      Padding(
                                        child: Text("",
                                            style: footerTextNormalStyle),
                                        padding: EdgeInsets.only(bottom: 15),
                                      ),
                                      Text("Glovo business",
                                          style: footerTextNormalStyle),
                                      Text("", style: footerTextNormalStyle),
                                      Text("", style: footerTextNormalStyle),
                                      Text("", style: footerTextNormalStyle),
                                    ])
                                  ],
                                )),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: EdgeInsets.only(top: 2),
                                      height: 70,
                                      child: IconButton(
                                          onPressed: () {},
                                          iconSize: 120,
                                          icon: Image.asset(
                                            'resources/images/download-button.png',
                                          ))),
                                  Container(
                                      height: 70,
                                      child: IconButton(
                                        onPressed: () {},
                                        iconSize: 120,
                                        icon: Image.asset(
                                          'resources/images/download-button_android.png',
                                        ),
                                      ))
                                ])
                          ]))))
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
    //final p = Path();
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
    paint.color = footerBackgroundColor;
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

// ignore: must_be_immutable
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

  Image motoDudeImg = Image.asset(
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
              painter: PathPainter(drawPathComplete()),
            ),
          ),
          motoDude(
              isfinished,
              calculate(_animation.value).dx,
              calculate(_animation.value).dy,
              calculateAngle(_animation.value).direction),
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

  Path drawPathComplete() {
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

  Offset calculateAngle(value) {
    PathMetrics pathMetrics = _path.computeMetrics();
    PathMetric pathMetric = pathMetrics.elementAt(0);
    value = pathMetric.length * value;
    Tangent pos = pathMetric.getTangentForOffset(value);
    return pos.vector;
  }

  Widget motoDude(bool finished, double posx, double posy, double angle) {
    if (!finished) {
      return Positioned(
          top: posy - 15,
          left: posx - 10,
          child: Transform.rotate(
            angle: angle,
            child: IconButton(
                onPressed: () {}, iconSize: size.toDouble(), icon: motoDudeImg),
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
    paint.color = footerBackgroundColor;
    paint.style = PaintingStyle.fill;

    canvas.drawPath(this.path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
