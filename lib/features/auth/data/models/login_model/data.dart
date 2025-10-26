class Data {
  String? token;
  String? username;
  String? email;

  Data({this.token, this.username, this.email});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json['token'] as String?,
    username: json['username'] as String?,
    email: json['email'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'token': token,
    'username': username,
    'email': email,
  };
}
