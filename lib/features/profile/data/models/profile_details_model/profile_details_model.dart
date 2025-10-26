import '../../../domain/entity/user_data_entity.dart';
import 'data.dart';

class ProfileDetailsModel extends UserDataEntity {
  dynamic message;
  UserData? data;
  String? status;

  ProfileDetailsModel({this.message, this.data, this.status});

  factory ProfileDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProfileDetailsModel(
      message: json['message'] as dynamic,
      data: json['data'] == null
          ? null
          : UserData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'data': data?.toJson(),
    'status': status,
  };
}
