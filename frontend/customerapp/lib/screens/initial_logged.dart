import 'package:customerapp/components/text_link.dart';
import 'package:customerapp/models/initial_logged.dart';
import 'package:customerapp/styles/initial_logged.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InitialLogged extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: InitialLoggedBar(),
        body: Center(
            child: Container(
                child: Center(
          child: Text(
            'Glovo',
            style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor),
          ),
        ))));
  }
}

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
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [SearchBox(), UserActions()],
              ))
        ],
      ),
      color: Theme.of(context).backgroundColor,
    );
  }
}

class UserActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
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
                  TextLink('Carrer de Diputació, 234', () {},
                      streetNameTextLinks, streetNameTextLinksHover),
                  TextLink('2n 1a', () {}, indicationsTextLinks,
                      indicationsTextLinksHover)
                ],
              )
            ],
          ),
          IconButton(
            iconSize: 35.0,
            color: Colors.white,
            icon: Icon(Icons.account_circle_outlined),
            onPressed: () {},
          ),
          IconButton(
            iconSize: 35.0,
            color: Colors.white,
            icon: Icon(Icons.format_list_bulleted_outlined),
            onPressed: () {},
          )
        ],
      ),
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
      TextLink('What do you need?', () {}, searchBarTextLinks,
          searchBarTextLinksHover)
    ]);
  }
}
