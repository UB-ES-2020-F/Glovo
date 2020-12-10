import 'package:customerapp/models/editPassword.dart';
import 'package:customerapp/screens/loggedPage/editPassword/editPassword_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class EditPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var editPasswordModel = context.watch<EditPasswordModel>();
    return Scaffold(
      body: ListView(children: [
        Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment(1, 1),
            child: IconButton(
              color: Color(0xFF6E6E6E),
              icon: Icon(Icons.clear),
              iconSize: 40,
              onPressed: () {
                editPasswordModel.obfuscateAll();
                Navigator.pop(context);
              },
            )),
        Container(padding: EdgeInsets.all(30), child: EditPassword())
      ]),
    );
  }
}
