import 'dart:convert';

Student studentFromJson(String str) => Student.fromJson(json.decode(str));

String studentToJson(Student data) => json.encode(data.toJson());

List<Student> studentsFromJson(String str) => List<Student>.from(
    json.decode(str)["data"].map((x) => Student.fromJson(x)));

String studentsToJson(List<Student> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Student {
  final int id;
  final String nis;
  final String name;
  String? gender;
  int? claassId;
  String? claassName;

  Student({
    required this.id,
    required this.nis,
    required this.name,
    this.gender,
    this.claassId,
    this.claassName,
  }) {
    gender ??= "-";
    claassId ??= 0;
    claassName ??= "";
  }

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        nis: json["nis"],
        name: json["name"],
        gender: json["gender"],
        claassId: json["claass_id"],
        claassName: json["claass_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nis": nis,
        "name": name,
        "gender": gender,
        "claass_id": claassId,
        "claass_name": claassName,
      };
}
