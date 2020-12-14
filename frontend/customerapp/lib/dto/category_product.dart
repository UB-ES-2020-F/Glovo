import 'package:customerapp/dto/product.dart';

class CategoryProductDTO {
  String name;
  List<ProductDTO> productsList;

  CategoryProductDTO(this.name, this.productsList);
}
