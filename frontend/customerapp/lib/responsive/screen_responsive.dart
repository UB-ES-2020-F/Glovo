import 'package:customerapp/components/appBar/default_logged_bar.dart';
import 'package:customerapp/components/appBar/mobile_default_bar.dart';
import 'package:flutter/widgets.dart';

class Bar_responsive {
  BuildContext context;
  String path; //the path to go when clicking menu button in the mobile bar
  Widget bar_big_screen;

  Bar_responsive(this.context, this.path, this.bar_big_screen);

  Widget get_responsive_bar() {
    if (MediaQuery.of(context).size.width > 600) {
      return bar_big_screen;
    } else {
      return Mobile_default_bar(path, ModalRoute.of(context).settings.name);
    }
  }
}

class Screen_responsive {
  BuildContext context;
  String path; //the path to go when clicking menu button in the mobile bar
  //Widget bar_big_screen;

  Screen_responsive(this.context, this.path);

  void get_responsive_screen() {
    if (MediaQuery.of(context).size.width > 600) {
      Navigator.pushNamed(context, '/sign-up');
    } else {
      //nothing
    }
  }
}
