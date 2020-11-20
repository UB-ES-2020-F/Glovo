import 'package:customerapp/actions/toast_actions.dart';
import 'package:customerapp/endpoints/user.dart';
import 'package:customerapp/infrastructure/persistence/repository/user_credentials_repository.dart';
import 'package:flutter/widgets.dart';

Future<void> logoutAndRedirectToWelcome(BuildContext context) async {
  try {
    await logout();
    await UserCredentialsRepository().removeCredentials();
    Navigator.pushNamedAndRemoveUntil(
        context, '/', (Route<dynamic> route) => false);
  } catch (ex) {
    showErrorToast("Unable to logout, contact the administrator");
  }
}
