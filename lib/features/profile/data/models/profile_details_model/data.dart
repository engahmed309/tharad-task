class UserData {
  int? id;
  String? username;
  String? email;
  String? image;

  UserData({this.id, this.username, this.email, this.image});

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json['id'] as int?,
    username: json['username'] as String?,
    email: json['email'] as String?,
    image: json['image'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'email': email,
    'image': image,
  };
}
