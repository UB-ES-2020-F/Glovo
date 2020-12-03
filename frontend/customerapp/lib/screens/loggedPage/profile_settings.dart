import 'package:customerapp/actions/logout.dart';
import 'package:customerapp/components/text_link.dart';
import 'package:customerapp/models/logged.dart';
import 'package:customerapp/screens/commonComponents/single_message_dialog.dart';
import 'package:customerapp/styles/initial_logged.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileSettings extends StatelessWidget {
  final double radiusDialog = 4;
  ProfileSettings(BuildContext context)
      : super(key: Key('profile-settings-menu'));
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
                child: SingleChildScrollView(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'PROFILE',
                        style: labelsProfileTitleText,
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 0.1,
                      height: 1,
                    ),
                    UserInformation(),
                  ],
                )),
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
              key: Key('profile-settings-name-section'),
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
              key: Key('profile-settings-name-value'),
              style: fieldsProfileText,
            ),
          ),
          Padding(
            key: Key('profile-settings-email-section'),
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
              key: Key('profile-settings-email-value'),
              style: fieldsProfileText,
            ),
          ),
        ])),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 2 * verticalPadding, 0, 0),
          child: Divider(
            color: Colors.black,
            thickness: 0.1,
            height: 1,
          ),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding:
                EdgeInsets.fromLTRB(0, 3 * verticalPadding, 0, verticalPadding),
            child: Row(
              key: Key('profile-settings-phone-section'),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Phone',
                  style: labelsProfileText,
                ),
                Text.rich(
                    TextSpan(text: 'Edit', style: editTextLinksBoldInactive))
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
        Padding(
          padding: EdgeInsets.fromLTRB(0, 2 * verticalPadding, 0, 0),
          child: Divider(
            color: Colors.black,
            thickness: 0.1,
            height: 1,
          ),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding:
                EdgeInsets.fromLTRB(0, 3 * verticalPadding, 0, verticalPadding),
            child: Row(
              key: Key('profile-settings-password-section'),
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
        Padding(
          padding: EdgeInsets.fromLTRB(0, 2 * verticalPadding, 0, 0),
          child: Divider(
            color: Colors.black,
            thickness: 0.1,
            height: 1,
          ),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding:
                EdgeInsets.fromLTRB(0, 3 * verticalPadding, 0, verticalPadding),
            child: Row(
              key: Key('profile-settings-card-section'),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Card',
                  style: labelsProfileText,
                ),
                Text.rich(
                    TextSpan(text: 'Create', style: editTextLinksBoldInactive))
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
        Padding(
          padding: EdgeInsets.fromLTRB(0, 2 * verticalPadding, 0, 0),
          child: Divider(
            color: Colors.black,
            thickness: 0.1,
            height: 1,
          ),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding:
                EdgeInsets.fromLTRB(0, 3 * verticalPadding, 0, verticalPadding),
            child: Row(
              key: Key('profile-settings-company-section'),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Company details',
                  style: labelsProfileText,
                ),
                Text.rich(
                    TextSpan(text: 'Create', style: editTextLinksBoldInactive)),
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
        Padding(
          padding: EdgeInsets.fromLTRB(0, 2 * verticalPadding, 0, 0),
          child: Divider(
            color: Colors.black,
            thickness: 0.1,
            height: 1,
          ),
        ),
        Padding(
          padding:
              EdgeInsets.fromLTRB(0, 3 * verticalPadding, 0, verticalPadding),
          child: Row(
            key: Key('profile-settings-logout-section'),
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextLink(
                'Logout',
                (context) async {
                  showLoaderDialog(context);
                  logoutAndRedirectToWelcome(context);
                },
                editTextLinksBold,
                editTextLinksHoverBold,
                context,
                key: Key('profile-settings-logout-button'),
              )
            ],
          ),
        ),
      ],
    );
  }
}
