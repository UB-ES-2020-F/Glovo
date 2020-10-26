import 'package:customerapp/components/text_link.dart';
import 'package:customerapp/models/initial_logged.dart';
import 'package:customerapp/styles/initial_logged.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
            'Komet',
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
                TextLink(initialLoggedModel.direction, () {},
                    streetNameTextLinks, streetNameTextLinksHover),
                TextLink(initialLoggedModel.indicationsDirection, () {},
                    indicationsTextLinks, indicationsTextLinksHover)
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
      TextLink('What do you need?', () {}, searchBarTextLinks,
          searchBarTextLinksHover)
    ]);
  }
}

class ProfileSettings extends StatelessWidget {
  final double verticalPadding = 5;
  final double radiusDialog = 13.0;
  ProfileSettings(BuildContext context);
  @override
  Widget build(BuildContext context) {
    var initialLoggedModel = InitialLoggedModel();
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 80, 60, 10),
      child: Align(
        alignment: Alignment(1, -1),
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusDialog),
          ),
          elevation: 0,
          color: Colors.white,
          child: SizedBox(
              width: 300.0,
              //height: 600.0,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PERFIL',
                      style: labelsProfileText,
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 0.3,
                    ),
                    Container(
                        width: 400.0,
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 2 * verticalPadding),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: verticalPadding),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Nombre',
                                          style: labelsProfileText,
                                        ),
                                        TextLink(
                                            'Editar',
                                            () {},
                                            editTextLinksBold,
                                            editTextLinksHoverBold)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: verticalPadding),
                                    child: Text(
                                      initialLoggedModel.firstName,
                                      style: fieldsProfileText,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: verticalPadding),
                                    child: Text(
                                      'E-mail',
                                      style: labelsProfileText,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: verticalPadding),
                                    child: Text(
                                      initialLoggedModel.email,
                                      style: fieldsProfileText,
                                    ),
                                  ),
                                ]))),
                    Divider(
                      color: Colors.black,
                      thickness: 0.3,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
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
