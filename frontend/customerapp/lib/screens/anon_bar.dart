import 'package:customerapp/components/text_link.dart';
import 'package:customerapp/models/logged.dart';
import 'package:customerapp/styles/initial_logged.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:customerapp/screens/loggedPage/profile_settings.dart';
import 'package:customerapp/screens/anon_root.dart';

class AnonBar extends StatelessWidget with PreferredSizeWidget {
  final double appBarHeight = 115.0;
  @override
  get preferredSize => Size.fromHeight(appBarHeight);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).backgroundColor,
              title: Padding(
                  padding: EdgeInsets.all(40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SearchBox(),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: SignUpButton(),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: LogInButton(),
                          ),
                        ],
                      )
                    ],
                  )))
        ],
      ),
      color: Theme.of(context).backgroundColor,
    );
  }
}

class SearchBox extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchBox_Stateful();
  }
}

class SearchBox_Stateful extends State<StatefulWidget> {
  var isHoveredColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        onHover: (value) {
          if (value) {
            setState(() {
              isHoveredColor = hoverIconColor;
            });
          } else {
            setState(() {
              isHoveredColor = Colors.white;
            });
          }
        },
        hoverColor: Colors.transparent,
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(
            iconSize: 50.0,
            color: isHoveredColor,
            hoverColor: Colors.transparent,
            icon: Icon(Icons.search_rounded),
            onPressed: () {},
          ),
          Text(
            "What do you need?",
            style: TextStyle(color: isHoveredColor, fontSize: 14),
          )
        ]));
  }
}
