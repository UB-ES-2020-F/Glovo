import 'package:flutter/cupertino.dart';
import 'package:latlong/latlong.dart';
import 'package:google_maps/google_maps.dart' as maps;

class MapLocationModel extends ChangeNotifier {
  LatLng _currentCoordinates;
  String _name = "";
  final _locationTextController = TextEditingController();
  final _indicationsTextController = TextEditingController();
  bool formValid = false;
  final geocoder = maps.Geocoder();

  TextEditingController get locationTextController => _locationTextController;
  TextEditingController get indicationsTextController =>
      _indicationsTextController;
  LatLng get currentCoordinates => _currentCoordinates;
  String get name => _name;

  set name(String value) {
    geocoder.geocode(maps.GeocoderRequest()..address = value,
        (results, status) {
      if (status == maps.GeocoderStatus.OK) {
        _name = value;
        _locationTextController.text = _name;
        final coordOfText = results[0].geometry.location;
        _currentCoordinates = LatLng(coordOfText.lat, coordOfText.lng);
        this.formValid = true;
      } else {
        this.formValid = false;
      }
      notifyListeners();
    });
  }
}
