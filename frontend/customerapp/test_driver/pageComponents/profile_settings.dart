import 'package:flutter_driver/flutter_driver.dart';

import '../actions/check-is-present.dart';
import '../objectKeys/profile_menu.dart';
import 'driver_page.dart';

class ProfileSettingsScreen extends DriverPage {
  ProfileSettingsScreen(FlutterDriver driver) : super(driver);
  Future<bool> isProfileMenuPresent() async {
    final profileSettingsMenu = find.byValueKey(profile_menu);
    return await isPresent(profileSettingsMenu, driver);
  }

  Future<bool> isSectionPresent(String sectionKey) async {
    final section = find.byValueKey(sectionKey);
    return await isPresent(section, driver);
  }

  Future<String> getName() async {
    final name = find.byValueKey(name_value);
    return await driver.getText(name);
  }

  Future<String> getEmail() async {
    final email = find.byValueKey(email_value);
    return await driver.getText(email);
  }
}
