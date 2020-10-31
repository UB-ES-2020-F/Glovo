import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:customerapp/screens/loggedPage/logged_bar.dart';
import 'package:hover_effect/hover_effect.dart';

class Prueba extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hover - Tilt 3D Effect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hover - Tilt 3D Effect',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  letterSpacing: 2),
            ),
            SizedBox(height: 50),
            Container(
              width: 150,
              height: 300,
              child: HoverCard(
                builder: (context, hovering) {
                  return Container(
                    color: Color(0xFFE9E9E9),
                    child: Center(
                      child: FlutterLogo(size: 100),
                    ),
                  );
                },
                depth: 10,
                depthColor: Colors.grey[500],
                onTap: () => print('Hello, World!'),
                shadow: BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
