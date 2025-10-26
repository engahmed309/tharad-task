class OtpModel {
	String? message;
	dynamic data;
	String? status;

	OtpModel({this.message, this.data, this.status});

	factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
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
