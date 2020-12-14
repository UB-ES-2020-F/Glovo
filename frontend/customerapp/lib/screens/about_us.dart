import 'dart:ui';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import 'package:customerapp/components/appBar/default_logged_bar.dart';
import 'package:customerapp/components/footer.dart';
import 'package:customerapp/models/aboutus.dart';
import 'package:customerapp/models/developer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var developers = DeveloperList();
    return Scaffold(
        appBar: AboutUsBar(),
        backgroundColor: Theme.of(context).primaryColorLight,
        body: Container(
            child: Padding(
                padding: EdgeInsets.only(top: 20),
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
                                padding: EdgeInsets.fromLTRB(50, 0, 50, 40),
                                child: Text(
                                  'OUR STORY',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).primaryColorDark),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
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
                                padding: EdgeInsets.fromLTRB(50, 50, 50, 20),
                                child: Text(
                                  'OUR TEAM',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).primaryColorDark),
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
                        Footer(Theme.of(context).primaryColorLight)
                      ]),
                ))))));
  }
}

class DeveloperListCard extends StatefulWidget {
  final Developer developer;

  DeveloperListCard(this.developer);

  @override
  State<StatefulWidget> createState() {
    return RestaurantsListCardState(developer);
  }
}

class RestaurantsListCardState extends State<StatefulWidget> {
  Developer developer;
  double elevation = 2;

  RestaurantsListCardState(this.developer);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
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
                        image: NetworkImage(developer.image),
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
        //color: Theme.of(context).backgroundColor,
        alignment: Alignment.center,
        child: Text(
          'About us',
          style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).accentColor),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Theme.of(context).backgroundColor,
                Theme.of(context).primaryColorLight
              ],
              begin: const FractionalOffset(0.0, 0.8),
              end: const FractionalOffset(0.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
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