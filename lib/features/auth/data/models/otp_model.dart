class SimpleModel {
  String? message;
  dynamic data;
  String? status;

  SimpleModel({this.message, this.data, this.status});

  factory SimpleModel.fromJson(Map<String, dynamic> json) => SimpleModel(
    message: json['message'] as String?,
    data: json['data'] as dynamic,
    status: json['status'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'message': message,
    'data': data,
    'status': status,
  };
}
