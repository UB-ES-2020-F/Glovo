import 'package:customerapp/actions/check_login.dart';
import 'package:customerapp/components/footer.dart';
import 'package:customerapp/dto/location.dart';
import 'package:customerapp/dto/restaurant.dart';
import 'package:customerapp/endpoints/location.dart';
import 'package:customerapp/endpoints/restaurants.dart';
import 'package:customerapp/exceptions/logout-callback-failed.dart';
import 'package:customerapp/exceptions/order-callback-failed.dart';
import 'package:customerapp/models/location.dart';
import 'package:customerapp/models/logged.dart';
import 'package:customerapp/models/map_location.dart';
import 'package:customerapp/models/update_model.dart';
import 'package:customerapp/responsive/screen_responsive.dart';
import 'package:customerapp/screens/commonComponents/anything_button.dart';
import 'package:customerapp/screens/commonComponents/food_button.dart';
import 'package:customerapp/screens/commonComponents/single_message_dialog.dart';
import 'package:customerapp/screens/commonComponents/snacks_button.dart';
import 'package:customerapp/screens/commonComponents/supermarkets_button.dart';
import 'package:customerapp/screens/location/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:customerapp/screens/loggedPage/logged_bar.dart';
import 'package:google_maps/google_maps.dart' as mapsOriginal;

class InitialLogged extends StatefulWidget {
  @override
  _InitialLogged createState() => _InitialLogged();
}

class _InitialLogged extends State<InitialLogged> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: userIsLogged(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data) {
            Widget bar;
            var locationModel = context.watch<MapLocationModel>();
            var loggedModel = context.watch<LoggedModel>();

            var update = context.watch<Update_model>();

            getlocation().then((value) {
              getAddress_fromPos(
                  mapsOriginal.Geocoder(),
                  LatLng((value as LocationDTO).latitude,
                      (value as LocationDTO).longitude),
                  locationModel,
                  loggedModel);
            }).catchError((onError) {});

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
              var update = context.watch<Update_model>();
              update.update_restaurants =false;
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
