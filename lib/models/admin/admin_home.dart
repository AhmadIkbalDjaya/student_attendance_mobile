// To parse this JSON data, do
//
//     final adminHome = adminHomeFromJson(jsonString);

import 'dart:convert';

AdminHome adminHomeFromJson(String str) =>
    AdminHome.fromJson(json.decode(str)['data']);

String adminHomeToJson(AdminHome data) => json.encode(data.toJson());

class AdminHome {
  final int claassCount;
  final int teacherCount;
  final int studentCount;
  final int courseCount;

  AdminHome({
    required this.claassCount,
    required this.teacherCount,
    required this.studentCount,
    required this.courseCount,
  });

  factory AdminHome.fromJson(Map<String, dynamic> json) => AdminHome(
        claassCount: json["claass_count"],
        teacherCount: json["teacher_count"],
        studentCount: json["student_count"],
        courseCount: json["course_count"],
      );

  Map<String, dynamic> toJson() => {
        "claass_count": claassCount,
        "teacher_count": teacherCount,
        "student_count": studentCount,
        "course_count": courseCount,
      };
}
