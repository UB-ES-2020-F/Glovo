import 'dart:html';

import 'package:customerapp/models/logged.dart';
import 'package:provider/provider.dart';
import 'package:customerapp/styles/Komet.dart';
import 'package:customerapp/styles/default_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Mobile_default_bar extends StatefulWidget with PreferredSizeWidget {
  String route_togo;
  String route_from;
  final double appBarHeight = 115.0 / 3;

  Mobile_default_bar(String route) {
    this.route_togo = route;
  }

  @override
  State<StatefulWidget> createState() {
    return Mobile_default_bar_state(route_togo);
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(appBarHeight);
}

class Mobile_default_bar_state extends State<StatefulWidget> {
  final double appBarHeight = 115.0 / 3;

  String route_togo;
  Color color_state_hover = Kommet_distinctive_green;
  Widget icon_state_hover = Image.asset(
    'resources/images/dropdown-light.png',
    scale: 1,
  );

  Mobile_default_bar_state(String route) {
    this.route_togo = route;
  }

  @override
  get preferredSize => Size.fromHeight(appBarHeight);
  @override
  Widget build(BuildContext context) {
    final loggedModel = context.watch<LoggedModel>();
    return AppBar(
        automaticallyImplyLeading: false,
        elevation: 3,
        backgroundColor: defaultAppBarBackgroundColor,
        title: Padding(
            padding: EdgeInsets.only(bottom: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pushNamed(context, route_togo),
                  icon: Image.asset(
                    'resources/images/menu.png',
                    scale: 0.9,
                  ),
                  iconSize: 0,
                ),
                InkWell(
                    onTap: () {},
                    onHover: (value) {
                      if (value == true) {
                        setState(() {
                          color_state_hover = Kommet_distinctive_green_hovered;
                          icon_state_hover = Image.asset(
                            'resources/images/dropdown-darkk.png',
                            scale: 1,
                          );
                        });
                      } else {
                        setState(() {
                          color_state_hover = Kommet_distinctive_green;
                          icon_state_hover = Image.asset(
                            'resources/images/dropdown-light.png',
                            scale: 1,
                          );
                        });
                      }
                    },
                    hoverColor: Colors.transparent,
                    child: Row(
                      children: [
                        Text(
                          getTrimmedDirection(loggedModel),
                          style: TextStyle(
                              color: color_state_hover,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: icon_state_hover,
                          hoverColor: Colors.transparent,
                          onPressed: () {
                            Navigator.pushNamed(context, '/location');
                          },
                        ),
                      ],
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                    )),

                IconButton(
                  icon: Image.asset(
                    'resources/images/search_mint.png',
                    scale: 1.6,
                  ),
                  iconSize: 10.0,
                  onPressed: () {},
                ), //UserActionsBar(BarType.defaultBar)
              ],
            )));
  }
}

String getTrimmedDirection(LoggedModel loggedModel) {
  String direction = loggedModel.getUserAndNotify().direction;
  return (direction.length <= 20)
      ? direction
      : direction.substring(0, 20) + "...";
}
