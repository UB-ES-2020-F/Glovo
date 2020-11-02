import 'package:customerapp/models/logged.dart';
import 'package:customerapp/models/product/product_overview.dart';
import 'package:customerapp/models/signup.dart';
import 'package:customerapp/screens/anon_bar.dart';
import 'package:customerapp/screens/loggedPage/initial_logged_page.dart';
import 'package:customerapp/screens/anon_root.dart';
import 'package:customerapp/screens/products/concrete_product_card.dart';
import 'package:customerapp/screens/products/products_sample.dart';

import 'package:customerapp/models/logged.dart';
import 'package:customerapp/models/signup.dart';
import 'package:customerapp/screens/loggedPage/initial_logged_page.dart';
import 'package:customerapp/screens/anon_root.dart';
import 'package:customerapp/screens/products/screen_product.dart';
import 'package:customerapp/screens/restaurantList/restaurant_list.dart';

import 'package:customerapp/screens/signIn/signin_page.dart';
import 'package:customerapp/screens/signUp/signup_page.dart';
import 'package:customerapp/styles/Komet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/restaurants.dart';
import 'models/signin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignUpModel()),
        ChangeNotifierProvider(create: (context) => LoggedModel()),
        ChangeNotifierProvider(create: (context) => SignInModel()),
        ChangeNotifierProvider(create: (context) => RestaurantsListModel()),
      ],
      child: MaterialApp(
          theme: appTheme,
          title: 'Komet',
          initialRoute: '/',
          routes: {
            '/': (context) => AnonRoute(),
            '/sign-up': (context) => SignUpPage(),
            '/sign-in': (context) => SignInPage(),
            '/products': (context) => Products_sample(),
            '/restaurant-list': (context) => RestaurantsList(),
            '/concrete_product': (context) => Screen_product(),
            '/initial-logged-in': (context) => InitialLogged(),
          }),
    );
  }
}
