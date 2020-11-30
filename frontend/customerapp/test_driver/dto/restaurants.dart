class RestaurantsDTO {
  List<DetailedRestaurantDTO> restaurants;
  RestaurantsDTO({this.restaurants});
  factory RestaurantsDTO.fromJson(List<dynamic> json) {
    return RestaurantsDTO(restaurants: getListOfRestaurantDTO(json));
  }
}

List<DetailedRestaurantDTO> getListOfRestaurantDTO(List jsonEncodedProducts) {
  return jsonEncodedProducts
      .map((json) => DetailedRestaurantDTO(
          json['id'],
          json['name'],
          json['imgPath'],
          json.containsKey('distance') ? json['distance'].toDouble() : null,
          json.containsKey('deliveryFee')
              ? json['deliveryFee'].toDouble()
              : null,
          json.containsKey('location')
              ? getLocationFromJson(json['location'])
              : null))
      .toList();
}

LocationDTO getLocationFromJson(Map<String, dynamic> json) {
  return LocationDTO(json['latitude'].toDouble(), json['longitude'].toDouble());
}

class DetailedRestaurantDTO {
  int id;
  String name;
  String imgPath;
  double distance;
  double deliveryFee;
  LocationDTO location;
  DetailedRestaurantDTO(this.id, this.name, this.imgPath, this.distance,
      this.deliveryFee, this.location);
}

class LocationDTO {
  double latitude;
  double longitude;
  LocationDTO(this.latitude, this.longitude);
}
