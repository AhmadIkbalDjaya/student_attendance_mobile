// To parse this JSON data, do
//
//     final adminRecap = adminRecapFromJson(jsonString);

import 'dart:convert';

List<AdminRecap> adminRecapFromJson(String str) => List<AdminRecap>.from(
    json.decode(str)["data"].map((x) => AdminRecap.fromJson(x)));

String adminRecapToJson(List<AdminRecap> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdminRecap {
  final int id;
  final String course;
  final String claass;

  AdminRecap({
    required this.id,
    required this.course,
    required this.claass,
  });

  factory AdminRecap.fromJson(Map<String, dynamic> json) => AdminRecap(
        id: json["id"],
        course: json["course"],
        claass: json["claass"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "course": course,
        "claass": claass,
      };
}
