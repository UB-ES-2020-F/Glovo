// Imports the Flutter Driver API.

import 'dart:math';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../data/location.dart';
import '../data/login.dart';
import '../endpointComponents/restaurants_endpoint.dart';
import '../endpointComponents/user_endpoint.dart';
import '../pageComponents/anonymouse_page.dart';
import '../pageComponents/location.dart';
import '../pageComponents/logged_user_page.dart';
import '../pageComponents/login_page.dart';
import '../pageComponents/restaurants_page.dart';

void main() {
  group('Profile settings tests', () {
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await createValidUserIfItDoesNotExist();
      await goToLoggedPage(driver);
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('restaurants are shown in the correct order given a location',
        () async {
      final loggedUserPage = LoggedUserPage(driver);
      final locationComponent = LocationComponent(driver);
      final restaurantsPage = RestaurantsPage(driver);
      await loggedUserPage.clickLocationButton();
      await locationComponent.introduceLocation(valid_location['location']);
      await locationComponent.closeDialog();
      await loggedUserPage.clickLocationButton();
      await locationComponent.introduceLocation(valid_location['location']);
      await locationComponent
          .introduceIndications(valid_location['indications']);
      await locationComponent.setLocation();
      final closestRestaurants = await getClosestRestaurants(
          valid_location['location_latitude'],
          valid_location['location_longitude']);
      await loggedUserPage.clickFoodBubbleButton();
      await wait(2); // Waiting restaurants are updated properly
      final maxIdx = max(5, closestRestaurants.restaurants.length);
      for (var i = 0; i < maxIdx; i++) {
        final restaurant = await restaurantsPage.getRestaurantWithIndex(i);
        expect(
            await restaurant.getName(), closestRestaurants.restaurants[i].name);
      }
    });
  });
}

Future<void> createValidUserIfItDoesNotExist() async {
  await createUser(validName, validUserEmail, validUserPassword);
}

Future<void> goToLoggedPage(FlutterDriver driver) async {
  final anonymousPage = AnonymousePage(driver);
  final loginPage = LoginPage(driver);
  await anonymousPage.clickLoginButton();
  await loginPage.fillEmail(validUserEmail);
  await loginPage.fillPassword(validUserPassword);
  await loginPage.clickSubmitLogin();
}

Future<void> wait(int secs) async {
  await Future.delayed(Duration(seconds: secs), () {});
}
