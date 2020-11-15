class ProductsDTO {
  List<DetailedProductDTO> products;
  ProductsDTO({this.products});
  factory ProductsDTO.fromJson(List<dynamic> json) {
    return ProductsDTO(products: getListOfProductsDTO(json));
  }
}

List<DetailedProductDTO> getListOfProductsDTO(List jsonEncodedProducts) {
  return jsonEncodedProducts
      .map((json) => DetailedProductDTO(
          json['id'],
          json['name'],
          json['imgPath'],
          json['description'],
          json['price'].toDouble(),
          json['restaurantId'],
          json['category'],
          json['categoryString']))
      .toList();
}

class DetailedProductDTO {
  int id;
  String name;
  String imgPath;
  String description;
  double price;
  int restaurantId;
  int category;
  String categoryString;
  DetailedProductDTO(this.id, this.name, this.imgPath, this.description,
      this.price, this.restaurantId, this.category, this.categoryString);
}
