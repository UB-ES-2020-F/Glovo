import 'dart:html';

import 'package:customerapp/components/appBar/user_actions_bar.dart';
import 'package:customerapp/styles/Komet.dart';
import 'package:customerapp/styles/default_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Mobile_default_bar extends StatelessWidget with PreferredSizeWidget {
  final double appBarHeight = 115.0;

  String route_togo;
  TabBar barra;

  Mobile_default_bar(String route, {TabBar bottom_tab_bar = null}) {
    this.route_togo = route;
    this.barra = bottom_tab_bar;
  }

  @override
  get preferredSize => Size.fromHeight(appBarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        bottom: barra,
        backgroundColor: defaultAppBarBackgroundColor,
        title: Padding(
            padding: EdgeInsets.all(40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pushNamed(context, route_togo),
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
                              color: Kommet_distinctive_green, fontSize: 20),
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
            )));
  }
}
