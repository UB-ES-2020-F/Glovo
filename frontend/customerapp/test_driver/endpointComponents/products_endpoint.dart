import 'dart:convert';

import 'package:http/http.dart' as http;
import '../data/exception_messages.dart';
import '../dto/products.dart';
import 'endpoints_definitions.dart';

Future<ProductsDTO> getProductsOfCategory(int categoryId) async {
  final response = await http.get(PRODUCTS_BY_CATEGORY(categoryId));
  if (response.statusCode != 200) throw Exception(CATEGORY_DOES_NOT_EXIST);
  return ProductsDTO.fromJson(json.decode(response.body));
}
