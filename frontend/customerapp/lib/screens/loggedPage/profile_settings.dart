import 'package:customerapp/components/text_link.dart';
import 'package:customerapp/models/logged.dart';
import 'package:customerapp/styles/initial_logged.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileSettings extends StatelessWidget {
  final double verticalPadding = 5;
  final double radiusDialog = 13.0;
  ProfileSettings(BuildContext context);
  @override
  Widget build(BuildContext context) {
    var initialLoggedModel = LoggedModel();
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 80, 60, 10),
      child: Align(
        alignment: Alignment(1, -1),
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusDialog),
          ),
          elevation: 0,
          color: Colors.white,
          child: SizedBox(
              width: 300.0,
              //height: 600.0,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PERFIL',
                      style: labelsProfileText,
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 0.3,
                    ),
                    Container(
                        width: 400.0,
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 2 * verticalPadding),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: verticalPadding),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Nombre',
                                          style: labelsProfileText,
                                        ),
                                        TextLink(
                                            'Editar',
                                            (context) {},
                                            editTextLinksBold,
                                            editTextLinksHoverBold,
                                            context)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: verticalPadding),
                                    child: Text(
                                      initialLoggedModel.firstName,
                                      style: fieldsProfileText,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: verticalPadding),
                                    child: Text(
                                      'E-mail',
                                      style: labelsProfileText,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: verticalPadding),
                                    child: Text(
                                      initialLoggedModel.email,
                                      style: fieldsProfileText,
                                    ),
                                  ),
                                ]))),
                    Divider(
                      color: Colors.black,
                      thickness: 0.3,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
