import 'package:customerapp/infrastructure/persistence/repository/user_credentials_repository.dart';
import 'package:flutter/material.dart';

import 'commonComponents/single_message_dialog.dart';

class RestrictedPage extends StatefulWidget {
  Widget _widgetToLoad;
  RestrictedPage(this._widgetToLoad);
  @override
  _RestrictedPage createState() => _RestrictedPage(this._widgetToLoad);
}

class _RestrictedPage extends State<RestrictedPage> {
  Widget _widgetToLoad;
  _RestrictedPage(this._widgetToLoad);
  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: userIsLogged(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              return _widgetToLoad;
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

Future<bool> userIsLogged() =>
    UserCredentialsRepository().getCredentials().then((value) => value != null);
