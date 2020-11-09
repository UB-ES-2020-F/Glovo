import 'package:customerapp/models/product/product_overview.dart';
import 'package:customerapp/screens/products/concrete_product_card.dart';

class Mock_up_prod {
  List _prods = List();

  Mock_up_prod() {
    _prods.add(Concrete_Product_Card(Product_overview(
        "Macarrons",
        "a la bolonyesa",
        12,
        "https://www.elgourmetcatala.cat/wp-content/uploads/2016/11/macarrones-a-la-bolo%C3%B1esa.jpg")));
    _prods.add(Concrete_Product_Card(Product_overview(
        "Tortellini",
        "als quatre formatges",
        11,
        'https://www.mujerdeelite.com/fotos/1073/1073_l.jpg')));
    _prods.add(Concrete_Product_Card(Product_overview(
        "Raviolis",
        "amb espinacs i salsa de formatge",
        12,
        'https://sevilla.abc.es/gurme/wp-content/uploads/sites/24/2013/09/ravioli-espinaca-queso.jpg')));
    _prods.add(Concrete_Product_Card(Product_overview(
        "Espaguetis",
        "a la carbonara",
        13,
        'https://superpola.com//site/assets/files/23425/402.jpg')));
    _prods.add(Concrete_Product_Card(Product_overview(
        "Tiramisú",
        "de la casa",
        5,
        'https://www.gimmesomeoven.com/wp-content/uploads/2020/07/Tiramisu-Recipe-Cover.jpg')));
  }

  List get prod {
    return _prods;
  }
}
