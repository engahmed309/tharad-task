import 'data.dart';

class RegisterModel {
  String? message;
  RegisterData? data;
  String? status;

  RegisterModel({this.message, this.data, this.status});

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    message: json['message'] as String?,
    data: json['data'] == null
        ? null
        : RegisterData.fromJson(json['data'] as Map<String, dynamic>),
    status: json['status'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'message': message,
    'data': data?.toJson(),
    'status': status,
  };
}
