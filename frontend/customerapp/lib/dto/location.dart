class LocationDTO {
  double longitude;
  double latitude;

  LocationDTO({this.latitude, this.longitude});

  factory LocationDTO.fromJson(Map<String, dynamic> json) {
    return LocationDTO(
        longitude: (json.containsKey('longitude')) ? json['longitude'] : null,
        latitude: (json.containsKey('latitude')) ? json['latitude'] : null);
  }

  Map<String, dynamic> toJson() {
    var toReturn = {
      'longitude': longitude,
      'latitude': latitude,
    };
    return toReturn;
  }
}
