import 'package:hive/hive.dart';

part 'user_credentials.g.dart';

@HiveType(typeId: 1)
class UserCredentials {
  @HiveField(0)
  String email;
  @HiveField(1)
  String token;
  @HiveField(2)
  int userId;

  UserCredentials(this.email, this.token, this.userId);
}
