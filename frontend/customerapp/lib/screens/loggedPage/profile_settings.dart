import 'package:customerapp/components/text_link.dart';
import 'package:customerapp/models/logged.dart';
import 'package:customerapp/styles/initial_logged.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileSettings extends StatelessWidget {
  final double radiusDialog = 4;
  ProfileSettings(BuildContext context);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 80, 60, 10),
      child: Align(
        alignment: Alignment(1, -1),
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusDialog),
          ),
          elevation: 5,
          color: Colors.white,
          child: SizedBox(
              width: 300.0,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PROFILE',
                      style: labelsProfileText,
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 0.1,
                      height: 1,
                    ),
                    UserInformation(),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

class UserInformation extends StatelessWidget {
  final double verticalPadding = 6;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding:
                EdgeInsets.fromLTRB(0, 3 * verticalPadding, 0, verticalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Name',
                  style: labelsProfileText,
                ),
                TextLink('Edit', (context) {}, editTextLinksBold,
                    editTextLinksHoverBold, context)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: verticalPadding),
            child: Text(
              LoggedModel.user.name,
              style: fieldsProfileText,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: verticalPadding),
            child: Text(
              'Email',
              style: labelsProfileText,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: verticalPadding),
            child: Text(
              LoggedModel.user.email,
              style: fieldsProfileText,
            ),
          ),
        ])),
        Divider(
          color: Colors.black,
          thickness: 0.1,
          height: 1,
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding:
                EdgeInsets.fromLTRB(0, 3 * verticalPadding, 0, verticalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Phone',
                  style: labelsProfileText,
                ),
                TextLink('Edit', (context) {}, editTextLinksBold,
                    editTextLinksHoverBold, context)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: verticalPadding),
            child: Text(
              "-",
              style: fieldsProfileText,
            ),
          ),
        ]),
        Divider(
          color: Colors.black,
          thickness: 0.1,
          height: 1,
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding:
                EdgeInsets.fromLTRB(0, 3 * verticalPadding, 0, verticalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Password',
                  style: labelsProfileText,
                ),
                TextLink('Edit', (context) {}, editTextLinksBold,
                    editTextLinksHoverBold, context)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: verticalPadding),
            child: Text(
              "************",
              style: fieldsProfileText,
            ),
          ),
        ]),
        Divider(
          color: Colors.black,
          thickness: 0.1,
          height: 1,
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding:
                EdgeInsets.fromLTRB(0, 3 * verticalPadding, 0, verticalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Card',
                  style: labelsProfileText,
                ),
                TextLink('Create', (context) {}, editTextLinksBold,
                    editTextLinksHoverBold, context)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: verticalPadding),
            child: Text(
              "-",
              style: fieldsProfileText,
            ),
          ),
        ]),
        Divider(
          color: Colors.black,
          thickness: 0.1,
          height: 1,
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding:
                EdgeInsets.fromLTRB(0, 3 * verticalPadding, 0, verticalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Company details',
                  style: labelsProfileText,
                ),
                TextLink('Create', (context) {}, editTextLinksBold,
                    editTextLinksHoverBold, context)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: verticalPadding),
            child: Text(
              "-",
              style: fieldsProfileText,
            ),
          ),
        ]),
        Divider(
          color: Colors.black,
          thickness: 0.1,
          height: 1,
        ),
        Padding(
          padding:
              EdgeInsets.fromLTRB(0, 3 * verticalPadding, 0, verticalPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextLink('Logout', (context) {}, editTextLinksBold,
                  editTextLinksHoverBold, context)
            ],
          ),
        ),
      ],
    );
  }
}
