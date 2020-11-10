import 'package:customerapp/components/appBar/mobile_default_bar.dart';
import 'package:customerapp/components/text_link.dart';
import 'package:customerapp/models/logged.dart';
import 'package:customerapp/models/signin.dart';
import 'package:customerapp/responsive/screen_responsive.dart';
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
                  /*Container(
                      //height: 10,
                      padding: EdgeInsets.all(0),
                      alignment: Alignment(1, 1),
                      child: IconButton(
                        hoverColor: Colors.transparent,
                        color: Color(0xFF6E6E6E),
                        icon: Icon(Icons.clear),
                        iconSize: 15,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )),*/
                  //new Expanded(child: new Container()),
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
        body: new TabBarView(
          children: <Widget>[
            Subpage_orders(),
            Subpage_user_profile(),
          ],
        ),
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
          Row(
            children: [
              Expanded(child: Container()),
              IconButton(
                iconSize: 40,
                icon: Image.asset(
                  'resources/images/arrow_diag.png',
                  scale: 0.9,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                alignment: Alignment(1, -1),
              )
            ],
          )
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
                    Divider(
                      color: Colors.black,
                      thickness: 0.3,
                    ),
                    Container(
                        child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 2 * 10.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.0),
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
                                            (context) {},
                                            editTextLinksBold,
                                            editTextLinksHoverBold,
                                            context)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      model.firstName,
                                      style: fieldsProfileText,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      'E-mail',
                                      style: labelsProfileText,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      model.email,
                                      style: fieldsProfileText,
                                    ),
                                  ),
                                ]))),
                    Divider(
                      color: Colors.black,
                      thickness: 0.3,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Teléfono',
                                  style: labelsProfileText,
                                ),
                                TextLink(
                                    'Editar',
                                    (context) {},
                                    editTextLinksBold,
                                    editTextLinksHoverBold,
                                    context)
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "-",
                              style: fieldsProfileText,
                            ),
                          ),
                        ]),
                    Divider(
                      color: Colors.black,
                      thickness: 0.3,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Contraseña',
                                  style: labelsProfileText,
                                ),
                                TextLink(
                                    'Editar',
                                    (context) {},
                                    editTextLinksBold,
                                    editTextLinksHoverBold,
                                    context)
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "************",
                              style: fieldsProfileText,
                            ),
                          ),
                        ])
                  ])),
          Row(
            children: [
              Expanded(child: Container()),
              IconButton(
                iconSize: 40,
                icon: Image.asset(
                  'resources/images/arrow_diag.png',
                  scale: 0.9,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                alignment: Alignment(1, -1),
              )
            ],
          )
        ]);
  }
}
