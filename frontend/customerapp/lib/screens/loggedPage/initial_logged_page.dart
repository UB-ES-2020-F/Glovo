import 'package:customerapp/actions/check_login.dart';
import 'package:customerapp/components/footer.dart';
import 'package:customerapp/infrastructure/persistence/repository/user_credentials_repository.dart';
import 'package:customerapp/responsive/screen_responsive.dart';
import 'package:customerapp/screens/commonComponents/anything_button.dart';
import 'package:customerapp/screens/commonComponents/food_button.dart';
import 'package:customerapp/screens/commonComponents/single_message_dialog.dart';
import 'package:customerapp/screens/commonComponents/snacks_button.dart';
import 'package:customerapp/screens/commonComponents/supermarkets_button.dart';
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

            var s = Bar_responsive(
                context, '/overview-mobile', InitialLoggedBar(),
                medium_bar: InitialLoggedBar_short());
            bar = s.get_responsive_bar();

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
                                        Text(
                                          'Komet ',
                                          key: Key(
                                              'initial-logged-in-komet-title-text'),
                                          style: TextStyle(
                                              fontSize: 50,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .accentColor),
                                        ),
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
