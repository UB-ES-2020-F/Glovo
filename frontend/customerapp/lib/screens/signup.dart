import 'package:customerapp/models/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var signUpModel = context.watch<SignUpModel>();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  child: Text('Regístrate en Glovo',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
