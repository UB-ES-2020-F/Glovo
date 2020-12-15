import 'dart:ui';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import 'package:customerapp/components/appBar/default_logged_bar.dart';
import 'package:customerapp/components/footer.dart';
import 'package:customerapp/models/aboutus.dart';
import 'package:customerapp/models/developer.dart';
import 'package:customerapp/styles/initial_logged.dart';
import 'package:customerapp/screens/loggedPage/initial_logged_page.dart';
import 'package:customerapp/styles/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var developers = DeveloperList();
    return Scaffold(
        appBar: AboutUsBar(),
        backgroundColor: Colors.white,
        body: Container(
            color: Colors.white,
            child: Padding(
                padding: EdgeInsets.only(top: 0),
                child: Center(
                    child: SingleChildScrollView(
                        child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 220,
                                transform:
                                    Matrix4.translationValues(0.0, -70.0, 0.0),
                                child: WhiteZoneOurStory(),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
                                transform:
                                    Matrix4.translationValues(0.0, -50.0, 0.0),
                                child: Text(
                                  aboutUsFirstPart,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          Theme.of(context).primaryColorDark),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(50, 0, 50, 80),
                                child: Wrap(
                                    spacing: 20,
                                    runSpacing: 20,
                                    alignment: WrapAlignment.center,
                                    children: [
                                      Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          child: Container(
                                              width: 200,
                                              height: 43,
                                              alignment: Alignment.bottomCenter,
                                              child: SizedBox.expand(
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      js.context
                                                          .callMethod('open', [
                                                        'https://docs.google.com/presentation/d/1fegH7hYsDV5UIJDCQ63WvQtCj_IhJdzHEYxv9inB-QM/edit?usp=sharing'
                                                      ]);
                                                    },
                                                    child: Text('Presentation'),
                                                    style: registerButtonStyle.copyWith(
                                                        textStyle: MaterialStateProperty
                                                            .resolveWith((states) =>
                                                                TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700)))),
                                              ))),
                                      Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          child: Container(
                                              width: 200,
                                              height: 43,
                                              alignment: Alignment.bottomCenter,
                                              child: SizedBox.expand(
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      js.context.callMethod(
                                                          'open', [
                                                        'https://wiki-ub-es2020-glovo.herokuapp.com/'
                                                      ]);
                                                    },
                                                    child: Text('Wiki'),
                                                    style: registerButtonStyle.copyWith(
                                                        textStyle: MaterialStateProperty
                                                            .resolveWith((states) =>
                                                                TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700)))),
                                              ))),
                                    ]),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(50, 0, 50, 20),
                                child: Text(
                                  'OUR TEAM',
                                  textAlign: TextAlign.center,
                                  style: mediumTextStyle,
                                ),
                              ),
                              Container(
                                  constraints: BoxConstraints(
                                      minWidth: 100, maxWidth: 800),
                                  padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
                                  child: StaggeredGridView.countBuilder(
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    physics:
                                        NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                                    shrinkWrap: true,
                                    itemCount: 5,
                                    crossAxisCount: 2,
                                    itemBuilder: (context, index) {
                                      return DeveloperListCard(
                                          developers.developers[index]);
                                    },
                                    staggeredTileBuilder: (int index) =>
                                        StaggeredTile.fit(1),
                                  ))
                            ]),
                        Footer(Colors.white),
                      ]),
                ))))));
  }
}

class DeveloperListCard extends StatefulWidget {
  final Developer developer;

  DeveloperListCard(this.developer);

  @override
  State<StatefulWidget> createState() {
    return DeveloperListCardState(developer);
  }
}

class DeveloperListCardState extends State<StatefulWidget> {
  Developer developer;
  double elevation = 2;

  DeveloperListCardState(this.developer);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black26, width: 1),
          borderRadius: BorderRadius.circular(20)),
      elevation: this.elevation,
      child: Container(
          child: Column(
        children: [
          InkWell(
              onHover: (value) {
                if (value) {
                  setState(() {
                    elevation = 8;
                  });
                } else {
                  setState(() {
                    elevation = 2;
                  });
                }
              },
              onTap: () => redirectGithubURL(context, developer),
              child: Container(
                alignment: Alignment.bottomCenter,
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          developer.image,
                        ),
                        fit: BoxFit.cover)),
                padding: EdgeInsets.only(bottom: 10, left: 0, right: 0, top: 0),
              )),
          Container(
            constraints: BoxConstraints(minHeight: 150),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            alignment: Alignment.center,
            child: InkWell(
                onTap: () => redirectGithubURL(context, developer),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        developer.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColorDark),
                      ),
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: [
                          Text(
                            'Github Username: ',
                            style: TextStyle(
                                fontSize: 16,
                                //fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            developer.githubUsername,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColorDark),
                          ),
                        ],
                      ),
                      Text(
                        'Roles:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            //fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        developer.roles,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColorDark),
                      ),
                    ])),
          )
        ],
      )),
    ));
  }

  void redirectGithubURL(BuildContext context, Developer developer) {
    js.context.callMethod('open', [developer.githubLink]);
  }
}

// ignore: must_be_immutable
class AboutUsBar extends StatelessWidget with PreferredSizeWidget {
  BuildContext context;
  AboutUsBar([this.context]);

  @override
  get preferredSize {
    final double appBarHeight = 160;
    return Size.fromHeight(appBarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Theme.of(context).backgroundColor,
        alignment: Alignment.center,
        child: Text(
          'About us',
          style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).accentColor),
        ),
      ),
      Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.fromLTRB(40, 25, 40, 0),
          transform: Matrix4.translationValues(0.0, -55.0, 0.0),
          child: Logo()),
    ]);
  }
}

class WhiteZoneOurStory extends StatelessWidget {
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
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 50),
                    child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "OUR STORY",
                          textAlign: TextAlign.center,
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
