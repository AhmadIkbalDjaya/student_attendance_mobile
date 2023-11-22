// To parse this JSON data, do
//
//     final teacherHome = teacherHomeFromJson(jsonString);

import 'dart:convert';

TeacherHome teacherHomeFromJson(String str) =>
    TeacherHome.fromJson(json.decode(str)["data"]);

String teacherHomeToJson(TeacherHome data) => json.encode(data.toJson());

class TeacherHome {
  final int claassCount;
  final int courseCount;
  final int studentCount;
  final int attendanceCount;
  final int attendanceNullCount;

  TeacherHome({
    required this.claassCount,
    required this.courseCount,
    required this.studentCount,
    required this.attendanceCount,
    required this.attendanceNullCount,
  });

  factory TeacherHome.fromJson(Map<String, dynamic> json) => TeacherHome(
        claassCount: json["claass_count"],
        courseCount: json["course_count"],
        studentCount: json["student_count"],
        attendanceCount: json["attendance_count"],
        attendanceNullCount: json["attendance_null_count"],
      );

  Map<String, dynamic> toJson() => {
        "claass_count": claassCount,
        "course_count": courseCount,
        "student_count": studentCount,
        "attendance_count": attendanceCount,
        "attendance_null_count": attendanceNullCount,
      };
}
