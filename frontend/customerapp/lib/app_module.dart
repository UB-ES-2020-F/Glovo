import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:customerapp/components/appBar/overview_logged_mobile.dart';
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

import 'main.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [];

  @override
  Widget get bootstrap => KometApp();

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (context, __) => AnonRoute()),
        ModularRouter('/sign-up', child: (context, __) => SignUpPage()),
        ModularRouter('/sign-in', child: (context, __) => SignInPage()),
        ModularRouter('/edit-name-email',
            child: (context, __) => EditNameEmailPage()),
        ModularRouter('/forgot-password',
            child: (context, __) => ForgotPasswordPage()),
        ModularRouter('/forgot-password-success',
            child: (context, __) => ForgotPasswordSuccessPage()),
        ModularRouter('/reset-password/:email/:token',
            child: (context, args) => ResetPasswordPage(
                email: args.params['email'], token: args.params['token'])),
        ModularRouter('/edit-password',
            child: (context, __) => EditPasswordPage()),
        ModularRouter('/location', child: (context, __) => LocationPage()),
        ModularRouter('/products', child: (context, __) => Products()),
        ModularRouter('/restaurant-list',
            child: (context, __) => RestaurantsList()),
        ModularRouter('/concrete-product',
            child: (context, __) => ProductScreen()),
        ModularRouter('/initial-logged-in',
            child: (context, __) => InitialLogged()),
        ModularRouter('/overview-mobile',
            child: (context, __) => TabBarScreen()),
      ];
}
