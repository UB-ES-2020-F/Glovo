// Imports the Flutter Driver API.

import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../data/login.dart';
import '../endpointComponents/user_endpoint.dart';
import '../objectKeys/profile_menu.dart';
import '../pageComponents/anonymouse_page.dart';
import '../pageComponents/logged_user_page.dart';
import '../pageComponents/login_page.dart';
import '../pageComponents/profile_settings.dart';

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

    test('profile settings menu is opened when profile button is clicked',
        () async {
      final loggedUserPage = LoggedUserPage(driver);
      final profileSettingsScreen = ProfileSettingsScreen(driver);
      await loggedUserPage.clickProfileButton();
      expect(await profileSettingsScreen.isProfileMenuPresent(), true);
    });
    test('all sections exist when the profile settings is shown', () async {
      final profileSettingsScreen = ProfileSettingsScreen(driver);
      expect(await profileSettingsScreen.isSectionPresent(name_section), true);
      expect(await profileSettingsScreen.isSectionPresent(email_section), true);
      expect(await profileSettingsScreen.isSectionPresent(phone_section), true);
      expect(
          await profileSettingsScreen.isSectionPresent(password_section), true);
      expect(await profileSettingsScreen.isSectionPresent(card_section), true);
      expect(
          await profileSettingsScreen.isSectionPresent(company_section), true);
      expect(
          await profileSettingsScreen.isSectionPresent(logout_section), true);
    });
    test('name is correctly displayed when the profile settings is shown',
        () async {
      final profileSettingsScreen = ProfileSettingsScreen(driver);
      final name = await profileSettingsScreen.getName();
      expect(name, validName);
    });
    test('email is correctly displayed when the profile settings is shown',
        () async {
      final profileSettingsScreen = ProfileSettingsScreen(driver);
      final email = await profileSettingsScreen.getEmail();
      expect(email, validUserEmail);
    });
    test(
        'the user is logout and redirected to the initial page when the logout button is clicked',
        () async {
      final profileSettingsScreen = ProfileSettingsScreen(driver);
      await profileSettingsScreen.clickLogoutButton();
      expect(await profileSettingsScreen.isProfileMenuPresent(), false);
    });
    // This test can not be done until flutter driver adopts web, allowing to
    // "click outside". It should be tested manually.
    /*
    test('profile settings is not shown when clicking outside profile settings',
        () async {
    });
    */
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
