import 'package:customerapp/infrastructure/persistence/repository/user_credentials_repository.dart';

Future<bool> userIsLogged() =>
    UserCredentialsRepository().getCredentials().then((value) => value != null);
