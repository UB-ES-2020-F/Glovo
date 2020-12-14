import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class UpdateModel extends ChangeNotifier {
  //testing variables. Will get real variables from backend
  bool updateRestaurants = false;

  void update() {
    updateRestaurants = true;
    notifyListeners();
  }
}
