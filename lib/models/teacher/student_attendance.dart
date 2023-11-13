// To parse this JSON data, do
//
//     final studentAttendance = studentAttendanceFromJson(jsonString);

import 'dart:convert';

StudentAttendance studentAttendanceFromJson(String str) =>
    StudentAttendance.fromJson(json.decode(str)["data"]);

String studentAttendanceToJson(StudentAttendance data) =>
    json.encode(data.toJson());

class StudentAttendance {
  final Attendance attendance;
  final List<StudentAttendanceElement> studentAttendances;

  StudentAttendance({
    required this.attendance,
    required this.studentAttendances,
  });

  factory StudentAttendance.fromJson(Map<String, dynamic> json) =>
      StudentAttendance(
        attendance: Attendance.fromJson(json["attendance"]),
        studentAttendances: List<StudentAttendanceElement>.from(
            json["student_attendances"]
                .map((x) => StudentAttendanceElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "attendance": attendance.toJson(),
        "student_attendances":
            List<dynamic>.from(studentAttendances.map((x) => x.toJson())),
      };
}

class Attendance {
  final int id;
  final String title;
  final String claass;
  final String course;
  final String datetime;
  final int studentCount;

  Attendance({
    required this.id,
    required this.title,
    required this.claass,
    required this.course,
    required this.datetime,
    required this.studentCount,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        id: json["id"],
        title: json["title"],
        claass: json["claass"],
        course: json["course"],
        datetime: json["datetime"],
        studentCount: json["student_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "claass": claass,
        "course": course,
        "datetime": datetime,
        "student_count": studentCount,
      };
}

class StudentAttendanceElement {
  final int id;
  final String studentName;
  final String nis;
  final String gender;
  final String statusId;

  StudentAttendanceElement({
    required this.id,
    required this.studentName,
    required this.nis,
    required this.gender,
    required this.statusId,
  });

  factory StudentAttendanceElement.fromJson(Map<String, dynamic> json) =>
      StudentAttendanceElement(
        id: json["id"],
        studentName: json["student_name"],
        nis: json["nis"],
        gender: json["gender"],
        statusId: json["status_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "student_name": studentName,
        "nis": nis,
        "gender": gender,
        "status_id": statusId,
      };
}
