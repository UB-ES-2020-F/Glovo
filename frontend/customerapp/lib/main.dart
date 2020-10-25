import 'package:customerapp/models/signup.dart';
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
      ],
      child: MaterialApp(
          theme: appTheme,
          title: 'Komet',
          initialRoute: '/sign-up',
          routes: {'/sign-up': (context) => SignUp()}),
    );
  }
}
