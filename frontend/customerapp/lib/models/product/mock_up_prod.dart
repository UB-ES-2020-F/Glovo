import 'package:customerapp/models/product/product_overview.dart';
import 'package:customerapp/screens/products/concrete_product_card.dart';

class Mock_up_prod {
  List _prods = List();

  Mock_up_prod() {
    _prods.add(Concrete_Product_Card(Product_overview(
        "Macarrons",
        "a la italiana",
        12,
        "https://t1.rg.ltmcdn.com/es/images/9/1/0/macarrones_con_pollo_faciles_y_deliciosos_71019_orig.jpg")));
    _prods.add(Concrete_Product_Card(Product_overview(
        "Tortellini",
        "a la italiana",
        11,
        'https://www.culinaryhill.com/wp-content/uploads/2015/11/Cheese-Tortellini-in-Garlic-Butter-Sauce-Culinary-Hill-square-e1579200909823.jpg')));
    _prods.add(Concrete_Product_Card(Product_overview(
        "Ravioli",
        "a la italiana",
        12,
        'https://bigoven-res.cloudinary.com/image/upload/d_recipe-no-image.jpg,t_recipe-480/cheeseravioliwithfreshtomatoan-96e38b.jpg')));
    _prods.add(Concrete_Product_Card(Product_overview(
        "Spaguetti",
        "a la italiana",
        13,
        'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/homemade-spaghetti-sauce-horizontal-1530890913.jpg')));
    _prods.add(Concrete_Product_Card(Product_overview(
        "Tiramisu",
        "estilo clasico",
        5,
        'https://www.gimmesomeoven.com/wp-content/uploads/2020/07/Tiramisu-Recipe-Cover.jpg')));
  }

  List get prod {
    return _prods;
  }
}
