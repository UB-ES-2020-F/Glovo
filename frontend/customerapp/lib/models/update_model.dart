import 'package:customerapp/models/location.dart';
import 'package:customerapp/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class Update_model extends ChangeNotifier {
  //testing variables. Will get real variables from backend
  bool update_restaurants = false;

  Update_model update() {
    update_restaurants = true;
    notifyListeners();
  }
}
