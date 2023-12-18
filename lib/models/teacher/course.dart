// To parse this JSON data, do
//
//     final course = courseFromJson(jsonString);

import 'dart:convert';

Course courseFromJson(String str) => Course.fromJson(json.decode(str));

String courseToJson(Course data) => json.encode(data.toJson());

class Course {
  final int id;
  final String name;
  final String claass;
  final String claassId;
  final String teacher;
  final String teacherId;
  final String semester;
  final String semesterId;
  final int studentCount;
  final int attendanceCount;

  Course({
    required this.id,
    required this.name,
    required this.claass,
    required this.claassId,
    required this.teacher,
    required this.teacherId,
    required this.semester,
    required this.semesterId,
    required this.studentCount,
    required this.attendanceCount,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        name: json["name"],
        claass: json["claass"],
        claassId: json["claass_id"],
        teacher: json["teacher"],
        teacherId: json["teacher_id"],
        semester: json["semester"],
        semesterId: json["semester_id"],
        studentCount: json["student_count"],
        attendanceCount: json["attendance_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "claass": claass,
        "claass_id": claassId,
        "teacher": teacher,
        "teacher_id": teacherId,
        "semester": semester,
        "semester_id": semesterId,
        "student_count": studentCount,
        "attendance_count": attendanceCount,
      };
}

Course dummyCourse = Course(
  id: 1,
  name: "Bahasa Indonesia",
  claass: "10 IPA 1",
  claassId: "1",
  teacher: "Nama Guru Pengajar",
  teacherId: "1",
  semester: "(Ganjil) 2020/2021",
  semesterId: "1",
  studentCount: 30,
  attendanceCount: 16,
);
