import 'package:customerapp/infrastructure/persistence/repository/user_credentials_repository.dart';
import 'package:customerapp/models/logged.dart';

Future<bool> userIsLogged() {
  return UserCredentialsRepository().getCredentials().then(
      (value) => value != null && LoggedModel.user.email != 'Unknown Email');
}
