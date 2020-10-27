import 'package:customerapp/components/text_link.dart';
import 'package:customerapp/models/initial_logged.dart';
import 'package:customerapp/styles/initial_logged.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:customerapp/screens/loggedPage/profile_settings.dart';

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
                    children: [SearchBox(), UserActions()],
                  )))
        ],
      ),
      color: Theme.of(context).backgroundColor,
    );
  }
}

class UserActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var initialLoggedModel = InitialLoggedModel();
    return Row(
      children: [
        Row(
          children: [
            IconButton(
              alignment: Alignment.topRight,
              iconSize: 22.0,
              color: Colors.white,
              icon: Icon(Icons.location_on_outlined),
              onPressed: () {},
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextLink(initialLoggedModel.direction, (context) {},
                    streetNameTextLinks, streetNameTextLinksHover, context),
                TextLink(initialLoggedModel.indicationsDirection, (context) {},
                    indicationsTextLinks, indicationsTextLinksHover, context)
              ],
            )
          ],
        ),
        IconButton(
          iconSize: 35.0,
          color: Colors.white,
          icon: Icon(Icons.account_circle_outlined),
          onPressed: () {
            _openProfileSettings(context);
          },
        ),
        IconButton(
          iconSize: 35.0,
          color: Colors.white,
          icon: Icon(Icons.format_list_bulleted_outlined),
          onPressed: () {},
        )
      ],
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

void _openProfileSettings(BuildContext context) {
  Navigator.of(context).push(
    PageRouteBuilder(
        pageBuilder: (context, _, __) => ProfileSettings(context),
        opaque: false,
        barrierDismissible: true,
        reverseTransitionDuration: Duration(milliseconds: 0)),
  );
}
