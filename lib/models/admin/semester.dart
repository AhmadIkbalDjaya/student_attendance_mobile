import 'dart:convert';

Semester semesterFromJson(String str) =>
    Semester.fromJson(json.decode(str)["data"]);

String semesterToJson(Semester data) => json.encode(data.toJson());

List<Semester> semestersFromJson(String str) => List<Semester>.from(
    json.decode(str)["data"].map((x) => Semester.fromJson(x)));

String semestersToJson(List<Semester> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Semester {
  final int id;
  final String startYear;
  final String endYear;
  final String oddEven;
  final String isActive;

  Semester({
    required this.id,
    required this.startYear,
    required this.endYear,
    required this.oddEven,
    required this.isActive,
  });

  factory Semester.fromJson(Map<String, dynamic> json) => Semester(
        id: json["id"],
        startYear: json["start_year"],
        endYear: json["end_year"],
        oddEven: json["odd_even"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_year": startYear,
        "end_year": endYear,
        "odd_even": oddEven,
        "is_active": isActive,
      };
}
