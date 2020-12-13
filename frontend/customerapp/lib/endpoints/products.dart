import 'dart:convert';

import 'package:customerapp/dto/category_product.dart';
import 'package:customerapp/dto/product.dart';
import 'package:customerapp/endpoints/urls.dart';
import 'package:customerapp/exceptions/order-callback-failed.dart';
import 'package:customerapp/models/products.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;



Future<List<Category_productDTO>> getProductsFromRestaurant(int restaurantId) async {
  final response = await http.get(
      await EndpointDefinitions.makeRestaurantsProductsURL(restaurantId),
      headers: {
        "Content-Type": "application/json",
      });
  if (response.statusCode == 200) {
   List<dynamic> decoded = json.decode(response.body);


   List<Category_productDTO> l = <Category_productDTO>[];
   List<ProductDTO> products = <ProductDTO>[];

    for (var category in decoded){

      print(category['category']);
      
      for(var prod in category['products']){
        products.add(ProductDTO.fromJson(prod));
      }
      
      l.add(Category_productDTO(category['category'],List.of(products)));

      products.clear();
    }

    return l;
  } else {
    throw OrderCallbackFailed(
        'Failed to login', response.statusCode, response.body);
  }
}

