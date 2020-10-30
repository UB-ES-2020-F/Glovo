import 'package:customerapp/components/appBar/user_actions_bar.dart';
import 'package:customerapp/components/text_link.dart';
import 'package:customerapp/styles/initial_logged.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InitialLoggedBar extends StatelessWidget with PreferredSizeWidget {
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
                    children: [SearchBox(), UserActionsBar(BarType.initial)],
                  )))
        ],
      ),
      color: Theme.of(context).backgroundColor,
    );
  }
}

class SearchBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      IconButton(
        iconSize: 50.0,
        color: Colors.white,
        icon: Icon(Icons.search_rounded),
        onPressed: () {},
      ),
      TextLink('What do you need?', (context) {}, searchBarTextLinks,
          searchBarTextLinksHover, context)
    ]);
  }
}
