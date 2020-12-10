import 'package:customerapp/app_module.dart';
import 'package:customerapp/components/appBar/overview_logged_mobile.dart';
import 'package:customerapp/infrastructure/persistence/hive/hive_adapter.dart';
import 'package:customerapp/infrastructure/persistence/repository/user_credentials_repository.dart';
import 'package:customerapp/models/forgotPassword.dart';
import 'package:customerapp/models/editPassword.dart';
import 'package:customerapp/models/logged.dart';
import 'package:customerapp/models/cart.dart';
import 'package:customerapp/models/resetPassword.dart';
import 'package:customerapp/models/signup.dart';
import 'package:customerapp/models/user_credentials/user_credentials.dart';
import 'package:customerapp/screens/forgotPassword/forgotPassword_page.dart';
import 'package:customerapp/screens/forgotPassword/forgotPassword_success.dart';
import 'package:customerapp/screens/forgotPassword/resetPassword_page.dart';
import 'package:customerapp/screens/location/location_page.dart';
import 'package:customerapp/screens/loggedPage/editNameEmail/editNameEmail_page.dart';
import 'package:customerapp/screens/loggedPage/editPassword/editPassword_page.dart';
import 'package:customerapp/screens/loggedPage/initial_logged_page.dart';
import 'package:customerapp/screens/anon_root.dart';
import 'package:customerapp/screens/products/products.dart';
import 'package:customerapp/screens/products/product_screen.dart';
import 'package:customerapp/screens/restaurantList/restaurant_list.dart';
import 'package:customerapp/screens/signIn/signin_page.dart';
import 'package:customerapp/screens/signUp/signup_page.dart';
import 'package:customerapp/styles/Komet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'app_config.dart';
import 'models/map_location.dart';
import 'models/changeNameEmail.dart';
import 'models/products.dart';
import 'models/restaurants.dart';
import 'models/signin.dart';

void main({String env}) async {
  WidgetsFlutterBinding.ensureInitialized();
  setUpPersistence();
  await AppConfig.setEnvironment(env);
  runApp(ModularApp(module: AppModule()));
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
        ChangeNotifierProvider(create: (context) => EditNameEmailModel()),
        ChangeNotifierProvider(create: (context) => EditPasswordModel()),
        ChangeNotifierProvider(create: (context) => RestaurantsListModel()),
        ChangeNotifierProvider(create: (context) => ForgotPasswordModel()),
        ChangeNotifierProvider(create: (context) => ResetPasswordModel()),
        ChangeNotifierProvider(create: (context) => ProductsListModel()),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => MapLocationModel()),
      ],
      child: MaterialApp(
        theme: appTheme,
        title: 'Komet',
        navigatorKey: Modular.navigatorKey,
        onGenerateRoute: Modular.generateRoute,
        initialRoute: '/reset-password',
      ),
    );
  }
}
