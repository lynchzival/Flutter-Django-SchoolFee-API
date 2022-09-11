import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.username,
    this.password,
    required this.refresh,
    required this.access,
  });

  dynamic username;
  dynamic password;
  String refresh;
  String access;

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: "",
        password: "",
        refresh: json["refresh"],
        access: json["access"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "refresh": refresh,
        "access": access,
      };
}
