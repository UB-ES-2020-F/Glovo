import 'package:latlong/latlong.dart';

double computeDistance(double lat1, double long1, double lat2, double long2) {
  final Distance distance = Distance();
  return distance.as(
      LengthUnit.Kilometer, LatLng(lat1, long1), LatLng(lat2, long2));
}
