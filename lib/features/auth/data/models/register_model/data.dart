class RegisterData {
  String? email;
  String? image;
  String? username;
  int? otp;

  RegisterData({this.email, this.image, this.username, this.otp});

  factory RegisterData.fromJson(Map<String, dynamic> json) => RegisterData(
    email: json['email'] as String?,
    image: json['image'] as String?,
    username: json['username'] as String?,
    otp: json['otp'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'email': email,
    'image': image,
    'username': username,
    'otp': otp,
  };
}
