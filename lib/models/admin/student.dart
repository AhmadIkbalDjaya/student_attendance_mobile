import 'dart:convert';

Student studentFromJson(String str) =>
    Student.fromJson(json.decode(str)['data']);

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
  String? claassId;
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
    claassId ??= "-";
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

List<Student> dummyStudents = [
  Student(
    id: 1,
    nis: "123456",
    name: "Nama Lengkap Murid",
    gender: "male",
    claassId: "1",
    claassName: "10 IPA 1",
  ),
  Student(id: 2, nis: "123456", name: "Nama Lengkap Murid"),
  Student(id: 3, nis: "123456", name: "Nama Lengkap Murid"),
  Student(id: 4, nis: "123456", name: "Nama Lengkap Murid"),
  Student(id: 5, nis: "123456", name: "Nama Lengkap Murid"),
];
