import 'dart:html';

import 'package:customerapp/components/appBar/user_actions_bar.dart';
import 'package:customerapp/styles/Komet.dart';
import 'package:customerapp/styles/default_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Test_bar extends StatelessWidget with PreferredSizeWidget {
  final double appBarHeight = 115.0;

  String route_signup = '/sign-in';
  @override
  get preferredSize => Size.fromHeight(appBarHeight) / 2;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: borderAppBar, width: 1.0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: defaultAppBarBackgroundColor,
              title: Padding(
                  padding: EdgeInsets.all(40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, route_signup),
                        icon: Image.asset(
                          'resources/images/menu.png',
                          scale: 0.6,
                        ),
                        iconSize: 50.0,
                      ),
                      InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Text(
                                "Barcelona",
                                style: TextStyle(
                                    color: Kommet_distinctive_green,
                                    fontSize: 20),
                              ),
                              IconButton(
                                icon: Image.asset(
                                  'resources/images/dropdown-light.png',
                                  scale: 1,
                                ),
                              ),
                            ],
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                          )),

                      IconButton(
                        icon: Image.asset(
                          'resources/images/search_mint.png',
                          scale: 1,
                        ),
                        iconSize: 50.0,
                      ), //UserActionsBar(BarType.defaultBar)
                    ],
                  )))
        ],
      ),
    );
  }
}

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          return Navigator.pushNamed(context, '/restaurant-list');
        },
        child: Text(
          'Komet ',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).accentColor),
        ));
  }
}
