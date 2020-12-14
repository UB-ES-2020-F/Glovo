import 'dart:ui';
import 'package:customerapp/components/footer.dart';
import 'package:customerapp/responsive/screen_responsive.dart';
import 'package:customerapp/screens/loggedPage/initial_logged_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:customerapp/screens/anon_bar.dart';

class AnonRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget bar;

    var s = BarResponsive(context, '/sign-up', AnonBar());
    bar = s.getResponsiveBar();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: bar,
        body: Container(
            child: Padding(
                padding: EdgeInsets.only(top: 0),
                child: Center(
                    child: SingleChildScrollView(
                        child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 20),
                          color: Theme.of(context).backgroundColor,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'resources/images/name_and_logo.png',
                            width: 300,
                          ),
                        ),
                        Container(
                          height: 220,
                          child: WhiteZone(),
                        ),
                        if (MediaQuery.of(context).size.width > 300)
                          AppAdZone(),
                        Footer(Colors.white)
                      ]),
                ))))));
  }
}
