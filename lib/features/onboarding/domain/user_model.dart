import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  String id;
  @HiveField(1)
  String username;
  @HiveField(2)
  String avatarImagePath;
  @HiveField(3)
  bool agbAccepted;
  @HiveField(4)
  DateTime firstLogin;
  @HiveField(5)
  DateTime lastLogin;

  User(this.id, this.username, this.avatarImagePath, this.agbAccepted,
      this.firstLogin, this.lastLogin);
}
