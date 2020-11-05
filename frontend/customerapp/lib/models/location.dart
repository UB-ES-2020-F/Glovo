import 'dart:math';

class Location {
  double _latitude;
  double _longitude;

  Location(
    this._latitude,
    this._longitude,
  );

  double get latitude {
    return _latitude;
  }

  double get longitude {
    return _longitude;
  }

  double getDistanceKm(Location pos2) {
    const double R = 6371.0;
    double latRad1 = _latitude * pi / 180.0;
    double latRad2 = pos2.latitude * pi / 180.0;
    double difLat = (_latitude - pos2.latitude) * pi / 180.0;
    double difLon = (_longitude - pos2.longitude) * pi / 180.0;
    double a = sin(difLat / 2) * sin(difLat / 2) +
        cos(latRad1) * cos(latRad2) * sin(difLon / 2) * sin(difLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return R * c;
  }
}
