import 'package:customerapp/components/appBar/overview_logged_mobile.dart';
import 'package:customerapp/infrastructure/persistence/hive/hive_adapter.dart';
import 'package:customerapp/infrastructure/persistence/repository/user_credentials_repository.dart';
import 'package:customerapp/models/logged.dart';
import 'package:customerapp/models/cart.dart';
import 'package:customerapp/models/signup.dart';
import 'package:customerapp/models/user_credentials/user_credentials.dart';
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
import 'app_config.dart';
import 'models/products.dart';
import 'models/restaurants.dart';
import 'models/signin.dart';

void main({String env}) async {
  WidgetsFlutterBinding.ensureInitialized();
  setUpPersistence();
  await AppConfig.setEnvironment(env);
  runApp(KometApp());
}

void setUpPersistence() async {
  initFlutter();
  UserCredentialsRepository().setUp(UserCredentialsAdapter());
}

class KometApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignUpModel()),
        ChangeNotifierProvider(create: (context) => LoggedModel()),
        ChangeNotifierProvider(create: (context) => SignInModel()),
        ChangeNotifierProvider(create: (context) => RestaurantsListModel()),
        ChangeNotifierProvider(create: (context) => ProductsListModel()),
        ChangeNotifierProvider(create: (context) => Cart()),
      ],
      child: MaterialApp(
          theme: appTheme,
          title: 'Komet',
          initialRoute: '/initial-logged-in',
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
