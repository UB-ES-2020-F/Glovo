import 'package:customerapp/actions/check_login.dart';
import 'package:customerapp/components/footer.dart';
import 'package:customerapp/responsive/screen_responsive.dart';
import 'package:customerapp/screens/commonComponents/anything_button.dart';
import 'package:customerapp/screens/commonComponents/food_button.dart';
import 'package:customerapp/screens/commonComponents/single_message_dialog.dart';
import 'package:customerapp/screens/commonComponents/snacks_button.dart';
import 'package:customerapp/screens/commonComponents/supermarkets_button.dart';
import 'package:customerapp/styles/initial_logged.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:customerapp/screens/loggedPage/logged_bar.dart';

class InitialLogged extends StatefulWidget {
  @override
  _InitialLogged createState() => _InitialLogged();
}

class _InitialLogged extends State<InitialLogged> {
  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: userIsLogged(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data) {
            Widget bar;

            var s = BarResponsive(
                context, '/overview-mobile', InitialLoggedBar(),
                mediumBar: InitialLoggedBarShort());
            bar = s.getResponsiveBar();

            return Scaffold(
                backgroundColor: Theme.of(context).backgroundColor,
                appBar: bar,
                body: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Center(
                        child: Container(
                            child: Center(
                      child: SingleChildScrollView(
                          child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: MediaQuery.of(context).size.height,
                              ),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          'resources/images/name_and_logo.png',
                                          width: 250,
                                          key: Key(
                                              'initial-logged-in-komet-title-text'),
                                        ),
                                        Container(
                                            padding: EdgeInsets.fromLTRB(
                                                50, 50, 50, 0),
                                            constraints:
                                                BoxConstraints(maxWidth: 800),
                                            child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  "Anything you want",
                                                  style: bigTextStyle,
                                                ))),
                                        Container(
                                            padding: EdgeInsets.fromLTRB(
                                                80, 0, 80, 50),
                                            constraints:
                                                BoxConstraints(maxWidth: 800),
                                            child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  "Delivered in minutes",
                                                  style: bigTextStyle.copyWith(
                                                      fontSize: 48),
                                                ))),
                                        Container(
                                            constraints: BoxConstraints(
                                                maxHeight:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height -
                                                        184),
                                            padding: EdgeInsets.only(
                                                left: 25, right: 25),
                                            child: SingleChildScrollView(
                                                child: Wrap(
                                                    alignment:
                                                        WrapAlignment.center,
                                                    children: [
                                                  FoodButton(Key(
                                                      "food-bubble-button")),
                                                  SupermarketsButton(Key(
                                                      "supermarket-bubble-button")),
                                                  SnacksButton(Key(
                                                      "snacks-bubble-button")),
                                                  AnythingButton(Key(
                                                      "anything-bubble-button")),
                                                ])))
                                      ],
                                    ),
                                    Footer(Theme.of(context).backgroundColor),
                                  ]))),
                    )))));
          } else {
            Future.delayed(Duration.zero, () {
              Navigator.pushNamed(context, '/');
            });
            return CircularLoaderKomet();
            //
          }
        } else {
          return CircularLoaderKomet();
        }
      });
}
