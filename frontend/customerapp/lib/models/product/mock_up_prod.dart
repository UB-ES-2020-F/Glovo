import 'package:customerapp/models/product/product_overview.dart';
import 'package:customerapp/screens/products/concrete_product_card.dart';

class Mock_up_prod {
  List _prods = List();

  Mock_up_prod() {
    _prods.add(Concrete_Product_Card(Product_overview(
        1,
        "Macarrons",
        "https://www.elgourmetcatala.cat/wp-content/uploads/2016/11/macarrones-a-la-bolo%C3%B1esa.jpg",
        "a la bolonyesa",
        12,
        0)));
    _prods.add(Concrete_Product_Card(Product_overview(
        2,
        "Tortellini",
        'https://www.mujerdeelite.com/fotos/1073/1073_l.jpg',
        "als quatre formatges",
        11,
        0)));
    _prods.add(Concrete_Product_Card(Product_overview(
        3,
        "Raviolis",
        'https://sevilla.abc.es/gurme/wp-content/uploads/sites/24/2013/09/ravioli-espinaca-queso.jpg',
        "amb espinacs i salsa de formatge",
        12,
        0)));
    _prods.add(Concrete_Product_Card(Product_overview(
        4,
        "Espaguetis",
        'https://superpola.com//site/assets/files/23425/402.jpg',
        "a la carbonara",
        13,
        0)));
    _prods.add(Concrete_Product_Card(Product_overview(
        5,
        "Tiramisú",
        'https://www.gimmesomeoven.com/wp-content/uploads/2020/07/Tiramisu-Recipe-Cover.jpg',
        "de la casa",
        5,
        0)));
  }

  List get prod {
    return _prods;
  }
}
