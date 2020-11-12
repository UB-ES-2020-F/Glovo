import 'package:customerapp/infrastructure/persistence/repository/user_credentials_repository.dart';
import 'package:customerapp/models/logged.dart';

import 'package:customerapp/models/cart.dart';

import 'package:customerapp/models/signup.dart';
import 'package:customerapp/screens/loggedPage/initial_logged_page.dart';
import 'package:customerapp/screens/anon_root.dart';
import 'package:customerapp/screens/products/products_sample.dart';

import 'package:customerapp/screens/products/screen_product.dart';
import 'package:customerapp/screens/restaurantList/restaurant_list.dart';
import 'package:customerapp/screens/signIn/signin_page.dart';
import 'package:customerapp/screens/signUp/signup_page.dart';
import 'package:customerapp/styles/Komet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'infrastructure/persistence/hive/hive_adapter.dart';
import 'components/appBar/overview_logged_mobile.dart';
import 'models/restaurants.dart';
import 'models/signin.dart';
import 'models/user_credentials/user_credentials.dart';

void main() {
  setUpPersistence();

  /**
   * Example of how to use repositories. They are async so keep that in mind
   */
  UserCredentialsRepository().update(UserCredentials("ruben", "zkkkasd"));
  UserCredentialsRepository()
      .getCredentials()
      .then((value) => print(value.username));
  UserCredentialsRepository().update(UserCredentials("pedro", "zkkkasd"));
  UserCredentialsRepository()
      .getCredentials()
      .then((value) => print(value.username));

  /**
   * End example
   */

  runApp(MyApp());
}

void setUpPersistence() async {
  initFlutter();
  UserCredentialsRepository().setUp(UserCredentialsAdapter());
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
        ChangeNotifierProvider(create: (context) => Cart()),
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
            '/concrete_product': (context) => Screen_products(),
            '/initial-logged-in': (context) => InitialLogged(),
            '/overview_mobile': (context) => TabBar_screen(),
          }),
    );
  }
}
