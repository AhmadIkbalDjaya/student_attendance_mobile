// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str)['data']);

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  final String token;
  final User user;
  final String role;

  Login({
    required this.token,
    required this.user,
    required this.role,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        token: json["token"],
        user: User.fromJson(json["user"]),
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
        "role": role,
      };
}

class User {
  final int id;
  final String username;
  final String email;
  String? name;
  String? phone;
  String? gender;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.name,
    this.phone,
    this.gender,
  }) {
    name ??= "";
    phone ??= "";
    gender ??= "";
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        name: json["name"],
        phone: json["phone"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "name": name,
        "phone": phone,
        "gender": gender,
      };
}
