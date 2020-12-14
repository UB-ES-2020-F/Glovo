class ProductDTO {
  int id;
  String name;
  String description;
  String imgPath;
  double price;
  int restaurantId;

  ProductDTO(
      {this.id,
      this.name,
      this.description,
      this.imgPath,
      this.price,
      this.restaurantId});

  factory ProductDTO.fromJson(Map<String, dynamic> json) {
    return ProductDTO(
        id: (json.containsKey('id')) ? json['id'] : null,
        name: (json.containsKey('name')) ? json['name'] : null,
        description:
            (json.containsKey('description')) ? json['description'] : null,
        imgPath: (json.containsKey('imgPath')) ? json['imgPath'] : null,
        price: (json.containsKey('price')) ? json['price'].toDouble() : null,
        restaurantId:
            (json.containsKey('restaurantId')) ? json['restaurantId'] : null);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> toReturn = {};
    if (id != null) toReturn['id'] = id;
    if (name != null) toReturn['name'] = name;
    if (description != null) toReturn['description'] = description;
    if (imgPath != null) toReturn['imgPath'] = imgPath;
    if (price != null) toReturn['price'] = price;
    if (restaurantId != null) toReturn['restaurantId'] = restaurantId;
    return toReturn;
  }

  @override
  String toString() {
    return "product name: " + name;
  }
}
