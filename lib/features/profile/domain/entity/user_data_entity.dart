import 'package:hive/hive.dart';

part 'user_data_entity.g.dart';

@HiveType(typeId: 1)
class UserDataEntity extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? username;

  @HiveField(2)
  String? email;

  @HiveField(3)
  String? image;

  UserDataEntity({this.id, this.username, this.email, this.image});
}
