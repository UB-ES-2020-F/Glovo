import 'dart:math';
import 'dart:ui';
import 'dart:js' as js;
import 'package:customerapp/components/footer.dart';
import 'package:customerapp/models/aboutus.dart';
import 'package:customerapp/models/developer.dart';
import 'package:customerapp/styles/restaurant_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var developers = DeveloperList();
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
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
                                padding: EdgeInsets.fromLTRB(50, 70, 50, 40),
                                child: Text(
                                  'About us',
                                  style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).accentColor),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(150, 20, 150, 20),
                                child: Text(
                                  aboutUsFirstPart,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      //fontWeight: FontWeight.bold,
                                      color: Theme.of(context).accentColor),
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
                        Footer(Theme.of(context).backgroundColor)
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
            height: 150,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            alignment: Alignment.centerLeft,
            child: InkWell(
                onTap: () => redirectGithubURL(context, developer),
                child: Column(children: [
                  Text(
                    developer.name,
                    style: restaurantListCardName,
                  ),
                  Text(
                    developer.githubUsername,
                    style: restaurantListCardName,
                  ),
                  Text(
                    developer.roles,
                    style: restaurantListCardName,
                  )
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

class AboutUsBar extends StatelessWidget with PreferredSizeWidget {
  BuildContext context;
  AboutUsBar([this.context]);

  @override
  get preferredSize {
    final double appBarHeight = MediaQuery.of(context).size.width / 5;
    return Size.fromHeight(appBarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
    );
  }
}
