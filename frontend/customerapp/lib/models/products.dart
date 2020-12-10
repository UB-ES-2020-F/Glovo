import 'package:customerapp/dto/product.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ProductsListModel extends ChangeNotifier {
  List<Product> availableProducts;

  ProductsListModel() {
    availableProducts = List();
  }

  void addProduct(Product product) {
    availableProducts.add(product);
  }

  void removeProducts() {
    availableProducts.clear();
  }
}

class Product {
  String _name;
  String _description;
  double _price;
  String _imgPath;
  int _idProd;
  int _idRest;

  Product(this._idProd, this._name, this._imgPath, this._description,
      this._price, this._idRest);

  String get name {
    return _name;
  }

  int get idProd {
    return _idProd;
  }

  int get idRestaurant {
    return _idRest;
  }

  String get imgPath {
    return _imgPath;
  }

  String get description {
    return _description;
  }

  double get price {
    return _price;
  }

  factory Product.fromDTO(ProductDTO productDTO) {
    return Product(productDTO.id, productDTO.name, productDTO.imgPath,
        productDTO.description, productDTO.price, productDTO.restaurantId);
  }

  ProductDTO toDTO() {
    return ProductDTO(
        id: this._idProd,
        name: this._name,
        description: this._description,
        imgPath: this._imgPath,
        price: this._price,
        restaurantId: this._idRest);
  }
}
