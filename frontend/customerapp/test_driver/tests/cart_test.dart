// Imports the Flutter Driver API.

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../data/login.dart';
import '../endpointComponents/user_endpoint.dart';
import '../pageComponents/anonymouse_page.dart';
import '../pageComponents/cart_page.dart';
import '../pageComponents/logged_user_page.dart';
import '../pageComponents/login_page.dart';
import '../pageComponents/restaurant_page.dart';
import '../pageComponents/restaurants_page.dart';

void main() {
  group('Cart tests', () {
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await createValidUserIfItDoesNotExist();
      await goToRestaurantPage(driver);
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('cart starts with 0 elements', () async {
      final cartPage = CartPage(driver);
      final itemsInCart = await cartPage.countElementsInCart();
      expect(itemsInCart, 0);
    });
    test('a product is added to the cart when user clicks on add product',
        () async {
      final cartPage = CartPage(driver);
      final restaurantPage = RestaurantPage(driver);
      final firstProduct = await restaurantPage.getFirstProduct();
      await firstProduct.addToCart();
      final numberOfItemsInCart = await cartPage.countElementsInCart();
      expect(numberOfItemsInCart, 1);
    });

    test(
        'a product is removed from the cart when user clicks on its remove button',
        () async {
      final cartPage = CartPage(driver);
      final firstItemInCart = await cartPage.getFirstCartItem();
      await firstItemInCart.removeFromCart();
      final numberOfItemsInCart = await cartPage.countElementsInCart();
      expect(numberOfItemsInCart, 0);
    });
  });
}

Future<void> createValidUserIfItDoesNotExist() async {
  await createUser(validName, validUserEmail, validUserPassword);
}

Future<void> goToRestaurantPage(FlutterDriver driver) async {
  final anonymousPage = AnonymousePage(driver);
  final loginPage = LoginPage(driver);
  final loggedUserPage = LoggedUserPage(driver);
  final restaurantsPage = RestaurantsPage(driver);
  await anonymousPage.clickLoginButton();
  await loginPage.fillEmail(validUserEmail);
  await loginPage.fillPassword(validUserPassword);
  await loginPage.clickSubmitLogin();
  await loggedUserPage.clickFoodBubbleButton();
  await restaurantsPage.clickOnFirstRestaurant();
}
