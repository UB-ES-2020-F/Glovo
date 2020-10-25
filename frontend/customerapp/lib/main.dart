import 'package:customerapp/models/initial_logged.dart';
import 'package:customerapp/models/signup.dart';
import 'package:customerapp/screens/initial_logged.dart';
import 'package:customerapp/screens/signup.dart';
import 'package:customerapp/styles/Glovo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        ChangeNotifierProvider(create: (context) => InitialLoggedModel()),
      ],
      child: MaterialApp(
          theme: appTheme,
          title: 'Komet',
          initialRoute: '/initial-logged-in',
          debugShowCheckedModeBanner: false,
          routes: {
            '/initial-logged-in': (context) => InitialLogged(),
            '/sign-up': (context) => SignUp()
          }),
    );
  }
}
