import 'package:intl/intl.dart';

class OrderDTO {
  int id;
  int userId;
  DateTime buyDateTime;
  int restaurantId;
  List<ProductDTO> products;
  OrderDTO(
      {this.id,
      this.userId,
      this.buyDateTime,
      this.restaurantId,
      this.products});
  factory OrderDTO.fromJson(Map<String, dynamic> json) {
    return OrderDTO(
        id: (json.containsKey('id')) ? json['id'] : null,
        userId: (json.containsKey('userId')) ? json['userId'] : null,
        buyDateTime: getDateTimeFromJSONencoding(json['buyDateTime']),
        restaurantId: json['restaurantId'],
        products: getProducts(json['products'] as List));
  }
  Map<String, dynamic> toJson() {
    var toReturn = {
      'buyDateTime': formatDateTimeToJsonString(buyDateTime),
      'restaurantId': restaurantId,
      'products': products
          .map((productDTO) => {
                'productId': productDTO.productId,
                'quantity': productDTO.quantity
              })
          .toList()
    };
    if (id != null) toReturn['id'] = id;
    if (userId != null) toReturn['userId'] = userId;
    return toReturn;
  }
}

class ProductDTO {
  int productId;
  int quantity;
  ProductDTO(this.productId, this.quantity);
}

DateTime getDateTimeFromJSONencoding(String datetime) {
  return DateTime.parse(datetime.replaceAll('T', ' '));
}

String formatDateTimeToJsonString(DateTime dateTime) {
  var f = NumberFormat("00", "en_US");
  return '${dateTime.year}-${f.format(dateTime.month)}-${f.format(dateTime.day)}T${f.format(dateTime.hour)}:${f.format(dateTime.minute)}:${f.format(dateTime.second)}';
}

List<ProductDTO> getProducts(List jsonEncodedProducts) {
  return jsonEncodedProducts
      .map((json) => ProductDTO(json['restaurantId'], json['quantity']))
      .toList();
}
