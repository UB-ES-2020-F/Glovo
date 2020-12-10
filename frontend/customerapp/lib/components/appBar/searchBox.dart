import 'package:customerapp/styles/initial_logged.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchBox();
  }
}

class _SearchBox extends State<StatefulWidget> {
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
