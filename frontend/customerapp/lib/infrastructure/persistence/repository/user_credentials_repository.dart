import 'package:customerapp/infrastructure/persistence/hive/box.dart';
import 'package:customerapp/models/user_credentials/user_credentials.dart';

class UserCredentialsRepository {
  static const _boxName = "userCredentials";
  static final UserCredentialsRepository _userCredentialsRepository =
      UserCredentialsRepository._internal();
  PersistentBox<UserCredentials> _userCredentialsBox;
  factory UserCredentialsRepository() {
    return _userCredentialsRepository;
  }
  UserCredentialsRepository._internal();

  Future<UserCredentials> getCredentials() async {
    return _userCredentialsBox.getElement();
  }

  Future<void> removeCredentials() async {
    await _userCredentialsBox.removeElement();
  }

  Future<void> update(UserCredentials credentials) async {
    _userCredentialsBox.persistElement(credentials);
  }

  void setUp(UserCredentialsAdapter adapter) {
    _userCredentialsBox = PersistentBox(adapter, _boxName);
    _userCredentialsBox.initBox();
  }
}
