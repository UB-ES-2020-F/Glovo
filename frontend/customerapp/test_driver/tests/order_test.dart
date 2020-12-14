import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../actions/check-is-present.dart';
import '../data/login.dart';
import '../endpointComponents/user_endpoint.dart';
import '../objectKeys/cart.dart';
import '../pageComponents/anonymouse_page.dart';
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
      await createValidUserIfItDoesNotExist();
      await goToLoggedPage(driver);
      await goToRestaurantPage(driver);
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('add product to cart button is visible', () async {
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
      expect(
          await isPresent(find.byValueKey(cartMakeOrderButton), driver,
              timeout: Duration(seconds: 15)),
          true);
    });
  });
}

Future<void> createValidUserIfItDoesNotExist() async {
  await createUser(validName, validUserEmail, validUserPassword);
}

Future<void> goToRestaurantPage(FlutterDriver driver) async {
  final restaurantsPage = RestaurantsPage(driver);
  final loggedUserPage = LoggedUserPage(driver);
  await loggedUserPage.clickFoodBubbleButton();
  await restaurantsPage.clickOnFirstRestaurant();
}

Future<void> goToLoggedPage(FlutterDriver driver) async {
  final anonymousPage = AnonymousePage(driver);
  final loginPage = LoginPage(driver);
  await anonymousPage.clickLoginButton();
  await loginPage.fillEmail(validUserEmail);
  await loginPage.fillPassword(validUserPassword);
  await loginPage.clickSubmitLogin();
}
