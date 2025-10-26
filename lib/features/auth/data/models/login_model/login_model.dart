import 'data.dart';

class LoginModel {
  String? message;
  Data? data;
  String? status;

  LoginModel({this.message, this.data, this.status});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    message: json['message'] as String?,
    data: json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
    status: json['status'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'message': message,
    'data': data?.toJson(),
    'status': status,
  };
}
