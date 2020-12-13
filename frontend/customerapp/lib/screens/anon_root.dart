import 'dart:ui';
import 'package:customerapp/components/footer.dart';
import 'package:customerapp/responsive/screen_responsive.dart';
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
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: bar,
        body: Container(
            child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Center(
                    child: SingleChildScrollView(
                        child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'resources/images/name_and_logo.png',
                                width: 250,
                              ),
                            ]),
                        Footer(Theme.of(context).backgroundColor)
                      ]),
                ))))));
  }
}
