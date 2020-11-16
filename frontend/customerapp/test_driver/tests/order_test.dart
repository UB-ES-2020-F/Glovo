import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../actions/check-is-present.dart';
import '../data/login.dart';
import '../objectKeys/anonymous_page.dart';
import '../objectKeys/cart.dart';
import '../objectKeys/logged_page.dart';
import '../objectKeys/login.dart';
import '../objectKeys/restaurant.dart';
import '../objectKeys/restaurants.dart';
import '../pageComponents/anonymouse_page.dart';
import '../pageComponents/cart_page.dart';
import '../pageComponents/logged_user_page.dart';
import '../pageComponents/login_page.dart';
import '../pageComponents/restaurant_page.dart';
import '../pageComponents/restaurants_page.dart';

void main() {
  group('Order tests | ', () {
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await goToLogged(driver);
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('clicking for order button is visible', () async {
      /*final List<int> pixels = await driver.screenshot();
      final File file = new File('screenshots/scren3.png');
      await file.writeAsBytes(pixels);*/
      expect(
          await isPresent(find.byValueKey('product-card-0'), driver,
              timeout: Duration(seconds: 15)),
          true);
    });

    //first test
    test('clicking for order button is visible', () async {
      final restaurantPage = RestaurantPage(driver);
      final firstProduct = await restaurantPage.getFirstProduct();
      await firstProduct.addToCart();
      //await driver.tap(find.byValueKey(cartMakeOrderButton));
      expect(
          await isPresent(find.byValueKey(cartMakeOrderButton), driver,
              timeout: Duration(seconds: 15)),
          true);
    });

    /*test(
        'a product with correct restaurant is added and an order is made correctly',
        () async {
      final restaurantPage = RestaurantPage(driver);
      final firstProduct = await restaurantPage.getFirstProduct();
      await firstProduct.addToCart();
      await driver.tap(find.byValueKey(cartMakeOrderButton));
      expect(
          await isPresent(find.byValueKey('suc_order'), driver,
              timeout: Duration(seconds: 15)),
          true);
    });*/

    // Close the connection to the driver after the tests have completed.
  });
}

Future<void> goToRestaurantPage(FlutterDriver driver) async {
  final anonymousPage = AnonymousePage(driver);

  //await loggedUserPage.clickFoodBubbleButton();
  //await restaurantsPage.clickOnFirstRestaurant();
}

Future<void> goToLogged(FlutterDriver driver) async {
  final anonymousPage = AnonymousePage(driver);
  final loginPage = LoginPage(driver);
  final loggedUserPage = LoggedUserPage(driver);
  final restaurantsPage = RestaurantsPage(driver);
  await anonymousPage.clickLoginButton();
  await loginPage.fillEmail("prueba@gmail.com");
  await loginPage.fillPassword("hola");
  await loginPage.clickSubmitLogin();
  /*final List<int> pixels = await driver.screenshot();
  final File file = new File('screenshots/scren.png');
  await file.writeAsBytes(pixels);*/
  await loggedUserPage.clickFoodBubbleButton();
  /*final List<int> pixelss = await driver.screenshot();
  final File files = new File('screenshots/scren2.png');
  await files.writeAsBytes(pixelss);*/
  await restaurantsPage.clickOnFirstRestaurant();
}
