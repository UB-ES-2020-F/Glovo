import 'package:customerapp/screens/loggedPage/editNameEmail/editNameEmail_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../restricted_page.dart';

class EditNameEmailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RestrictedPage(this._build(context));
  }

  Widget _build(BuildContext context) {
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
                Navigator.pop(context);
              },
            )),
        Container(padding: EdgeInsets.all(30), child: EditNameEmail())
      ]),
    );
  }
}
