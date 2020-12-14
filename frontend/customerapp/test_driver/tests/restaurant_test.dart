import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import '../actions/check-is-present.dart';
import '../data/login.dart';
import '../endpointComponents/user_endpoint.dart';
import '../objectKeys/restaurant.dart';
import '../pageComponents/anonymouse_page.dart';
import '../pageComponents/logged_user_page.dart';
import '../pageComponents/login_page.dart';
import '../pageComponents/restaurants_page.dart';

void main() {
  group('Specific restaurant tests ', () {
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

    test(
        'displayed categories corresponds with categories for a specific restaurant',
        () async {
      await Future.delayed(Duration(seconds: 3), () {});
      // todo fix, the category tab is not being found by flutter driver
      expect(await isPresent(find.byValueKey(category('menu')), driver), true);
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
