import 'package:customerapp/components/appBar/mobile_default_bar.dart';
import 'package:customerapp/components/text_link.dart';
import 'package:customerapp/models/logged.dart';
import 'package:customerapp/models/signin.dart';
import 'package:customerapp/responsive/screen_responsive.dart';
import 'package:customerapp/screens/loggedPage/profile_settings.dart';
import 'package:customerapp/styles/Komet.dart';
import 'package:customerapp/styles/initial_logged.dart';
import 'package:customerapp/styles/overview_mobile_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabBar_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 650) {
      Navigator.pop(context); //when resizing screen slowly, error occurs
    }

    return DefaultTabController(
      length: 2,
      child: new Scaffold(
        appBar: new PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight * 0.8 + 28),
          child: new Container(
            color: Colors.white,
            child: new SafeArea(
                child: Padding(
              padding: EdgeInsets.only(right: 50, left: 50, top: 20),
              child: Column(
                children: <Widget>[
                  new TabBar(
                    labelStyle: NotSelectedStyle_bar,
                    labelColor: Kommet_distinctive_yellow,
                    unselectedLabelColor: Colors.black,
                    indicatorPadding: EdgeInsets.only(top: 50),
                    indicatorWeight: 4,
                    onTap: (value) {},
                    unselectedLabelStyle: SelectedStyle_bar,
                    indicatorColor: Kommet_distinctive_yellow,
                    tabs: [
                      Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text("Orders")),
                      Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text("Account"))
                    ],
                  ),
                ],
              ),
            )),
          ),
        ),
        body: Stack(children: [
          TabBarView(
            children: <Widget>[
              Subpage_orders(),
              Subpage_user_profile(),
            ],
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                iconSize: 36,
                icon: Image.asset(
                  'resources/images/arrow_diag.png',
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ))
        ]),
      ),
    );
  }
}

class Subpage_orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
              padding: EdgeInsets.only(top: 20, left: 50, right: 50),
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        "¡Ups! Parece que todavía no has hecho ningún pedido",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )),
                  Text(
                    "Conoce nuestras tiendas y encuentra todo lo que necesites",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class Subpage_user_profile extends StatelessWidget {
  var model = LoggedModel();

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserInformation(),
                  ]))
        ]);
  }
}
