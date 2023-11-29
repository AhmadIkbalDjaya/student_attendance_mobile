import 'dart:convert';

Teacher teacherFromJson(String str) =>
    Teacher.fromJson(json.decode(str)['data']);

String teacherToJson(Teacher data) => json.encode(data.toJson());

List<Teacher> teachersFromJson(String str) => List<Teacher>.from(
    json.decode(str)['data'].map((x) => Teacher.fromJson(x)));

String teachersToJson(List<Teacher> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Teacher {
  final int id;
  final String username;
  final String name;
  String? email;
  String? phone;
  String? gender;

  Teacher({
    required this.id,
    required this.username,
    required this.name,
    this.email,
    this.phone,
    this.gender,
  }) {
    email ??= "";
    phone ??= "";
    gender ??= "";
  }

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "email": email,
        "phone": phone,
        "gender": gender,
      };
}

List<Teacher> dummyTeachers = [
  Teacher(
      id: 1,
      username: "usernameGuru1",
      name: "Nama Guru 1",
      email: "emailguru1@gmail.com",
      phone: "xxxxxxxxxxxx",
      gender: "male"),
  Teacher(id: 2, username: "usernameGuru2", name: "Nama Guru 2"),
  Teacher(id: 3, username: "usernameGuru3", name: "Nama Guru 3"),
  Teacher(id: 4, username: "usernameGuru4", name: "Nama Guru 4"),
  Teacher(id: 5, username: "usernameGuru5", name: "Nama Guru 5"),
];
