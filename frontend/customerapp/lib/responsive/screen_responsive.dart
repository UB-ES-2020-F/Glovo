import 'package:customerapp/components/appBar/mobile_default_bar.dart';
import 'package:flutter/widgets.dart';

const MOBILE_MAX = 600;

class BarResponsive {
  BuildContext context;
  String path; //the path to go when clicking menu button in the mobile bar
  Widget barBigScreen;
  Widget barBigMedium;

  BarResponsive(this.context, this.path, this.barBigScreen, {mediumBar}) {
    this.barBigMedium = mediumBar;
  }

  Widget getResponsiveBar() {
    if (MediaQuery.of(context).size.width > 900) {
      return barBigScreen;
    }
    if (MediaQuery.of(context).size.width > MOBILE_MAX &&
        MediaQuery.of(context).size.width <= 900) {
      if (barBigMedium == null) {
        return barBigScreen;
      } else {
        return barBigMedium;
      }
    } else {
      return MobileDefaultBar(path);
    }
  }
}
