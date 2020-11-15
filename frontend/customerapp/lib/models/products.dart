import 'package:customerapp/dto/product.dart';
import 'package:customerapp/models/products.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ProductsListModel extends ChangeNotifier {
  List<Product> availableProducts;

  ProductsListModel() {
    availableProducts = List();
    availableProducts.add(Product(
        1,
        "Macarrons",
        "https://www.elgourmetcatala.cat/wp-content/uploads/2016/11/macarrones-a-la-bolo%C3%B1esa.jpg",
        "a la bolonyesa",
        12,
        0));
    availableProducts.add(Product(
        2,
        "Tortellini",
        'https://www.mujerdeelite.com/fotos/1073/1073_l.jpg',
        "als quatre formatges",
        11,
        0));
    availableProducts.add(Product(
        3,
        "Raviolis",
        'https://sevilla.abc.es/gurme/wp-content/uploads/sites/24/2013/09/ravioli-espinaca-queso.jpg',
        "amb espinacs i salsa de formatge",
        12,
        0));
    availableProducts.add(Product(
        4,
        "Espaguetis",
        'https://superpola.com//site/assets/files/23425/402.jpg',
        "a la carbonara",
        13,
        0));
    availableProducts.add(Product(
        5,
        "Tiramisú",
        'https://www.gimmesomeoven.com/wp-content/uploads/2020/07/Tiramisu-Recipe-Cover.jpg',
        "de la casa",
        5,
        0));
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
