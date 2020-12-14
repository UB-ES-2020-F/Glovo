import 'package:flutter_driver/flutter_driver.dart';

import '../objectKeys/location.dart';
import 'driver_page.dart';

class LocationComponent extends DriverPage {
  LocationComponent(FlutterDriver driver) : super(driver);
  Future<void> introduceLocation(String location) async {
    final locInput = find.byValueKey(locationInput);
    await driver.tap(locInput);
    await driver.enterText(location);
  }

  Future<void> introduceIndications(String indications) async {
    final indicationsInput = find.byValueKey(locationIndicationInput);
    await driver.tap(indicationsInput);
    await driver.enterText(indications);
  }

  Future<void> setLocation() async {
    final setLocButton = find.byValueKey(setLocationButton);
    await driver.tap(setLocButton);
  }

  Future<void> clickOnMap() async {
    final map = find.byValueKey(locationMap);
    await driver.tap(map);
  }

  Future<void> closeDialog() async {
    final closeButton = find.byValueKey(closeLocationDialogButton);
    await driver.tap(closeButton);
  }
}
