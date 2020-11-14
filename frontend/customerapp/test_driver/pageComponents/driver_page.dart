import 'package:flutter_driver/flutter_driver.dart';

abstract class DriverPage {
  FlutterDriver driver;
  DriverPage(this.driver);
}
