// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:customerapp/models/logged.dart';
import 'package:provider/provider.dart';
import 'package:customerapp/styles/Komet.dart';
import 'package:customerapp/styles/default_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MobileDefaultBar extends StatefulWidget with PreferredSizeWidget {
  final String routeToGo;
  final double appBarHeight = 115.0 / 3;

  MobileDefaultBar(this.routeToGo);

  @override
  State<StatefulWidget> createState() {
    return _MobileDefaultBar(routeToGo);
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}

class _MobileDefaultBar extends State<StatefulWidget> {
  final double appBarHeight = 115.0 / 3;

  String routeToGo;
  Color colorStateHover = kommetDistinctiveGreen;
  Widget iconStateHover = Image.asset(
    'resources/images/dropdown-light.png',
    scale: 1,
  );

  _MobileDefaultBar(String route) {
    this.routeToGo = route;
  }

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
                  onPressed: () => Navigator.pushNamed(context, routeToGo),
                  icon: Image.asset(
                    'resources/images/menu.png',
                    scale: 0.9,
                  ),
                  iconSize: 0,
                ),
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/location');
                    },
                    onHover: (value) {
                      if (value == true) {
                        setState(() {
                          colorStateHover = kommetDistinctiveGreenHovered;
                          iconStateHover = Image.asset(
                            'resources/images/dropdown-darkk.png',
                            scale: 1,
                          );
                        });
                      } else {
                        setState(() {
                          colorStateHover = kommetDistinctiveGreen;
                          iconStateHover = Image.asset(
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
                              color: colorStateHover,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        iconStateHover,
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
  String direction = loggedModel.getUser().direction;
  return (direction.length <= 20)
      ? direction
      : direction.substring(0, 20) + "...";
}
