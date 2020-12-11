import 'package:customerapp/actions/check_login.dart';
import 'package:customerapp/screens/commonComponents/single_message_dialog.dart';
import 'package:customerapp/screens/loggedPage/editNameEmail/editNameEmail_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EditNameEmailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditNameEmailPage();
}

class _EditNameEmailPage extends State<EditNameEmailPage> {
  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: userIsLogged(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
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
            } else {
              Future.delayed(Duration.zero, () {
                Navigator.pushNamed(context, '/');
              });
              return CircularLoaderKomet();
              //
            }
          } else {
            return CircularLoaderKomet();
          }
        },
      );
}
