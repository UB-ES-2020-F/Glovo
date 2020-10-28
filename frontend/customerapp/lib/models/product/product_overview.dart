class Product_overview {
  String _name;
  String _prod_description;
  double _price;

  Product_overview(this._name, this._prod_description, this._price);

  String get name {
    return _name;
  }

  String get prod_description {
    return _prod_description;
  }

  double get price {
    return _price;
  }
}
