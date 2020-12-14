// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:customerapp/actions/check_login.dart';
import 'package:customerapp/components/appBar/default_logged_bar.dart';
import 'package:customerapp/dto/category_product.dart';
import 'package:customerapp/models/cart.dart';
import 'package:customerapp/models/products.dart';
import 'package:customerapp/models/restaurants.dart';
import 'package:customerapp/screens/commonComponents/single_message_dialog.dart';
import 'package:customerapp/screens/products/cart_box.dart';
import 'package:customerapp/styles/Komet.dart';
import 'package:customerapp/styles/category_prod.dart';
import 'package:customerapp/styles/product.dart';
import 'package:customerapp/responsive/screen_responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:customerapp/endpoints/products.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'cart_box.dart';
import 'product_card.dart';

class Products extends StatefulWidget {
  @override
  _Products createState() => _Products();
}

class _Products extends State<Products> {
  List prods = List();
  Cart cart;
  bool firstInstance;

  ItemScrollController itemScrollController;
  ItemPositionsListener itemPositionsListener;

  List<String> cats;

  _Products() {
    firstInstance = true;
  }

  @override
  void initState() {
    itemScrollController = ItemScrollController();
    itemPositionsListener = ItemPositionsListener.create();
    super.initState();
  }

  void addToCart(Product prod) {
    cart.addItem(prod);
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: userIsLogged(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              final RestaurantLoc restaurant =
                  ModalRoute.of(context).settings.arguments;
              var productsModel = context.watch<ProductsListModel>();

              cart = context.watch<Cart>();
              if (firstInstance) {
                productsModel.removeProducts();
                cart.empty();
              }
              firstInstance = false;

              double cartWidth = 350;
              var s = BarResponsive(
                  context, '/overview-mobile', DefaultLoggedBar());
              var bar = s.getResponsiveBar();

              return Scaffold(
                  appBar: bar,
                  body: Stack(children: [
                    Container(
                        alignment: Alignment.topLeft,
                        width: MediaQuery.of(context).size.width,
                        //padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                            color: Color(0xFFE0E0E0),
                            image: DecorationImage(
                                image: NetworkImage(
                                    restaurant == null ? '' : restaurant.image),
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.topCenter)),
                        child: Column(children: [
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Expanded(
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                        Container(
                                          padding: MediaQuery.of(context)
                                                      .size
                                                      .width <
                                                  600
                                              ? EdgeInsets.fromLTRB(
                                                  10, 30, 10, 0)
                                              : EdgeInsets.fromLTRB(
                                                  30, 30, 30, 0),
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width <=
                                                  900
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  40
                                              : MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  cartWidth -
                                                  75,
                                          child: Builder(builder: (builder) {
                                            return FutureBuilder(
                                              future: getProductsFromRestaurant(
                                                  restaurant.id),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot snapshot2) {
                                                if (snapshot2.hasData) {
                                                  cats = (snapshot2.data as List<
                                                          CategoryProductDTO>)
                                                      .map((e) => e.name)
                                                      .toList();
                                                  List<Widget> grids = getGrids(
                                                      snapshot2.data,
                                                      productsModel);

                                                  return Column(children: [
                                                    Container(
                                                        height: 120,
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 0, 0, 10),
                                                          child: Container(
                                                            height: 140,
                                                            padding: EdgeInsets
                                                                .fromLTRB(40, 0,
                                                                    40, 0),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15.0),
                                                                color: Color(
                                                                    0xAAFFFFFF)),
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Column(
                                                                children: [
                                                                  Padding(
                                                                      padding: EdgeInsets.only(
                                                                          top:
                                                                              10),
                                                                      child:
                                                                          Text(
                                                                        restaurant ==
                                                                                null
                                                                            ? 'Products'
                                                                            : restaurant.name,
                                                                        style:
                                                                            restaurantTitleStyle,
                                                                      )),
                                                                  Divider(),
                                                                  //we construct the radiobutton with the cats
                                                                  CustomRadio(
                                                                      cats,
                                                                      itemScrollController),
                                                                ]),
                                                          ),
                                                        )),
                                                    Expanded(
                                                        child:
                                                            ScrollablePositionedList
                                                                .builder(
                                                      itemCount: grids.length,
                                                      itemBuilder:
                                                          (context, index) =>
                                                              grids[index],
                                                      itemScrollController:
                                                          itemScrollController,
                                                      itemPositionsListener:
                                                          itemPositionsListener,
                                                    ))
                                                  ]);
                                                } else {
                                                  return Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, 0, 10),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0),
                                                            color: Color(
                                                                0xAAFFFFFF)),
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child:
                                                            CircularLoaderKomet(),
                                                      ));
                                                }
                                              },
                                            );
                                          }),
                                        ),
                                      ])))),
                          //Bug for next Sprint
                          //Footer(Color(0x00000000))
                        ])),
                    if (MediaQuery.of(context).size.width <= 900 &&
                        cart.order.isNotEmpty)
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: MakeOrderButton(
                              Key('cart-make-order-button'),
                              cart,
                              'Make order of ' +
                                  cart.countItems().toString() +
                                  ' items (' +
                                  cart.getTotalPrice().toStringAsFixed(2) +
                                  ' €)')),
                    if (MediaQuery.of(context).size.width > 900)
                      Align(
                          alignment: Alignment.topRight,
                          child: Column(
                            children: [
                              CartBox(restaurant, cartWidth, cart, prods)
                            ],
                          ))
                    else
                      Container()
                  ]));
            } else {
              Future.delayed(Duration.zero, () {
                Navigator.pushNamed(context, '/');
              });
              return CircularLoaderKomet();
              //
            }
          } else {
            return CircularLoaderKomet();
          }
        },
      );

  //Returns a List<widgets> with each gridview for every category
  List<Widget> getGrids(List<CategoryProductDTO> l, ProductsListModel model) {
    List<Widget> toret = List();
    int count = -1;

    for (var category in l) {
      List<Product> p = List();
      for (var pp in category.productsList) {
        Product product;
        p.add(Product.fromDTO(pp));
        model.availableProducts.add(product);
      }
      count = count + 1;
      toret.add(Container(
        height: 50,
        child: Text(
          category.name,
          key: Key(category.name),
          style: categoryStyle,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Color(0xAAFFFFFF)),
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 5),
      ));
      count = count + 1;
      toret.add(StaggeredGridView.countBuilder(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        physics:
            NeverScrollableScrollPhysics(), // to disable GridView's scrolling
        shrinkWrap: true,
        itemCount: p.length,
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
        itemBuilder: (context, index) {
          return ProductListCard(
              Key('product-card-$index'), p[index], addToCart);
        },
        staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
      ));
    }
    return toret;
  }
}

// ignore: must_be_immutable
class CustomRadio extends StatefulWidget {
  CustomRadio(this.categories, this.controller);

  List<String> categories;
  ItemScrollController controller;

  @override
  State<StatefulWidget> createState() {
    return CustomRadioState(this.categories, this.controller);
  }
}

class CustomRadioState extends State<CustomRadio> {
  CustomRadioState(this.categories, this.controller);

  List<String> categories;
  ItemScrollController controller;
  List<RadioModel> sample = List<RadioModel>();

  @override
  void initState() {
    super.initState();
    for (var cat in categories) {
      sample.add(RadioModel(cat, false));
    }
  }

  List<Widget> generateWidgets() {
    int count = 0;
    List<Widget> llista = List<Widget>();
    sample.asMap().forEach((key, value) {
      int v = count;
      llista.add(InkWell(
          onTap: () {
            setState(() {
              sample.forEach((element) => element.isSelected = false);
              sample[key].isSelected = true;
            });
            controller.scrollTo(
                index: 2 * v, duration: Duration(milliseconds: 500));
          },
          child: ProductClassWidget(sample[key].name, sample[key].isSelected)));
      count++;
    });

    return llista;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: generateWidgets(),
    );
  }
}

// ignore: must_be_immutable
class ProductClassWidget extends StatelessWidget {
  ProductClassWidget(this.name, this.isSelected);

  bool isSelected;
  String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 10),
        child: Container(
            key: Key('category-${name.toLowerCase()}'),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                  child: Text(name,
                      style: isSelected
                          ? prodTextTitleStyle
                          : prodTextTitleStyleBasic)),
              Container(
                height: isSelected ? 7 : 0,
                width: name.length.toDouble() * 10,
                decoration: BoxDecoration(
                    color: kommetDistinctiveYellow,
                    borderRadius: BorderRadius.all(Radius.circular(40))),
              )
            ])));
  }
}

class RadioModel {
  RadioModel(this.name, this.isSelected);

  bool isSelected;
  String name;
}
