import 'package:customerapp/components/footer.dart';
import 'package:customerapp/dto/location.dart';
import 'package:customerapp/endpoints/location.dart';
import 'package:customerapp/exceptions/logout-callback-failed.dart';
import 'package:customerapp/models/logged.dart';
import 'package:customerapp/models/map_location.dart';
import 'package:customerapp/responsive/screen_responsive.dart';
import 'package:customerapp/screens/commonComponents/anything_button.dart';
import 'package:customerapp/screens/commonComponents/food_button.dart';
import 'package:customerapp/screens/commonComponents/snacks_button.dart';
import 'package:customerapp/screens/commonComponents/supermarkets_button.dart';
import 'package:customerapp/screens/location/map_screen.dart';
import 'package:customerapp/screens/restricted_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:customerapp/screens/loggedPage/logged_bar.dart';

import 'package:google_maps/google_maps.dart' as mapsOriginal;

class InitialLogged extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RestrictedPage(this._build(context));
  }

  Widget _build(BuildContext context) {
    Widget bar;
    var locationModel = context.watch<MapLocationModel>();
    var loggedModel = context.watch<LoggedModel>();

    getlocation().then((value) {
      getAddress_fromPos(
          mapsOriginal.Geocoder(),
          LatLng((value as LocationDTO).latitude,
              (value as LocationDTO).longitude),
          locationModel,
          loggedModel);
    }).catchError((onError) {});

    var s = Bar_responsive(context, '/overview-mobile', InitialLoggedBar(),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Komet ',
                                  key:
                                      Key('initial-logged-in-komet-title-text'),
                                  style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).accentColor),
                                ),
                                Container(
                                    constraints: BoxConstraints(
                                        maxHeight:
                                            MediaQuery.of(context).size.height -
                                                184),
                                    padding:
                                        EdgeInsets.only(left: 25, right: 25),
                                    child: SingleChildScrollView(
                                        child: Wrap(
                                            alignment: WrapAlignment.center,
                                            children: [
                                          FoodButton(Key("food-bubble-button")),
                                          SupermarketsButton(
                                              Key("supermarket-bubble-button")),
                                          SnacksButton(
                                              Key("snacks-bubble-button")),
                                          AnythingButton(
                                              Key("anything-bubble-button")),
                                        ]))),
                                InkWell(
                                    onTap: () {
                                      /*print("saving");
                                      savelocation(LocationDTO(
                                              latitude: locationModel
                                                  .currentCoordinates.latitude,
                                              longitude: locationModel
                                                  .currentCoordinates
                                                  .longitude))
                                          .then((value) {
                                        print("OK");
                                      }).catchError((onError) {
                                        var e = onError as LogoutCallbackFailed;
                                        print(e.cause);
                                        print(e.errorCode);
                                        print(e.responseBody);
                                        print("No OK");
                                      });*/
                                    },
                                    child: Text("sdsd")),
                                InkWell(
                                    onTap: () {
                                      print("saving");
                                      savelocation(LocationDTO(
                                              latitude: locationModel
                                                  .currentCoordinates.latitude,
                                              longitude: locationModel
                                                  .currentCoordinates
                                                  .longitude))
                                          .then((value) {
                                        print("OK");
                                      }).catchError((onError) {
                                        var e = onError as LogoutCallbackFailed;
                                        print(e.cause);
                                        print(e.errorCode);
                                        print(e.responseBody);
                                        print("No OK");
                                      });
                                      /*getlocation().then((value) {
                                        print("OK");
                                        print((value as LocationDTO).latitude);
                                        print((value as LocationDTO).longitude);
                                        print(getAddress_fromPos(
                                            mapsOriginal.Geocoder(),
                                            LatLng(
                                                (value as LocationDTO).latitude,
                                                (value as LocationDTO)
                                                    .longitude),
                                            locationModel));
                                      }).catchError((onError) {
                                        print("NO OK");
                                      });*/
                                    },
                                    child: Text("sdsassd"))
                              ],
                            ),
                            Footer(Theme.of(context).backgroundColor),
                          ]))),
            )))));
  }
}
