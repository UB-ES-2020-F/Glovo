import 'package:customerapp/components/appBar/default_logged_bar.dart';
import 'package:customerapp/components/appBar/mobile_default_bar.dart';
import 'package:customerapp/screens/loggedPage/logged_bar.dart';
import 'package:flutter/widgets.dart';

const MOBILE_MAX = 600;

class Bar_responsive {
  BuildContext context;
  String path; //the path to go when clicking menu button in the mobile bar
  Widget bar_big_screen;
  Widget bar_big_medium;

  Bar_responsive(this.context, this.path, this.bar_big_screen,
      {medium_bar = null}) {
    this.bar_big_medium = medium_bar;
  }

  Widget get_responsive_bar() {
    if (MediaQuery.of(context).size.width > 900) {
      return bar_big_screen;
    }
    if (MediaQuery.of(context).size.width > MOBILE_MAX &&
        MediaQuery.of(context).size.width <= 900) {
      if (bar_big_medium == null) {
        return bar_big_screen;
      } else {
        return bar_big_medium;
      }
    } else {
      return Mobile_default_bar(path);
    }
  }
}
