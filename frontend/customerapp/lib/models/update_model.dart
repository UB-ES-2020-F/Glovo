import 'package:customerapp/models/location.dart';
import 'package:customerapp/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class Update_model extends ChangeNotifier {
  //testing variables. Will get real variables from backend
  bool update_restaurants = false;

  static Update_model model = new Update_model();

  Update_model getUserAndNotify() {
    notifyListeners();
    return model;
  }

  void setUserAndNotify(bool t) {
    notifyListeners();
    update_restaurants = true;
    notifyListeners();
  }

  Update_model getUser() {
    return model;
  }
}
