class Product_overview {
  String _name;
  String _description;
  double _price;
  String _imgPath;
  int _idProd;
  int _idRest;

  Product_overview(this._idProd, this._name, this._imgPath, this._description,
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
}
