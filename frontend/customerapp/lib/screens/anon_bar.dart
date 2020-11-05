import 'package:customerapp/components/appBar/searchBox.dart';
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
