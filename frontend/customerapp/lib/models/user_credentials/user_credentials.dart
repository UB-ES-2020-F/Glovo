import 'package:hive/hive.dart';

part 'user_credentials.g.dart';

@HiveType(typeId: 1)
class UserCredentials {
  @HiveField(0)
  String username;
  @HiveField(1)
  String token;

  UserCredentials(this.username, this.token);
}