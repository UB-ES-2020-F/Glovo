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
    return 0;
  }
}
