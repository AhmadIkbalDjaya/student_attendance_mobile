// To parse this JSON data, do
//
//     final courseAttendance = courseAttendanceFromJson(jsonString);

import 'dart:convert';

import 'package:student_attendance/models/teacher/course.dart';

CourseAttendance courseAttendanceFromJson(String str) =>
    CourseAttendance.fromJson(json.decode(str)['data']);

Attendance attendanceFromJson(String str) =>
    Attendance.fromJson(json.decode(str)['data']);

String courseAttendanceToJson(CourseAttendance data) =>
    json.encode(data.toJson());

class CourseAttendance {
  final Course course;
  final List<Attendance> attendances;

  CourseAttendance({
    required this.course,
    required this.attendances,
  });

  factory CourseAttendance.fromJson(Map<String, dynamic> json) =>
      CourseAttendance(
        course: Course.fromJson(json["course"]),
        attendances: List<Attendance>.from(
            json["attendances"].map((x) => Attendance.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "course": course.toJson(),
        "attendances": List<dynamic>.from(attendances.map((x) => x.toJson())),
      };
}

class Attendance {
  final int id;
  final String title;
  final String datetime;
  final String courseId;
  final String course;
  final String isFilled;

  Attendance({
    required this.id,
    required this.title,
    required this.datetime,
    required this.courseId,
    required this.course,
    required this.isFilled,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        id: json["id"],
        title: json["title"],
        datetime: json["datetime"],
        courseId: json["course_id"],
        course: json["course"],
        isFilled: json["is_filled"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "datetime": datetime,
        "courseId": courseId,
        "course": course,
        "is_filled": isFilled,
      };
}

CourseAttendance dummyCourseAttendance = CourseAttendance(
  course: dummyCourse,
  attendances: [
    Attendance(
      id: 1,
      title: "Pertemuan 1",
      datetime: "1972-08-17 04:24:11",
      courseId: "1",
      course: "Bahasa Indonesia",
      isFilled: "0",
    ),
    Attendance(
      id: 2,
      title: "Pertemuan 2",
      datetime: "1972-08-17 04:24:11",
      courseId: "1",
      course: "Bahasa Indonesia",
      isFilled: "0",
    ),
    Attendance(
      id: 3,
      title: "Pertemuan 3",
      datetime: "1972-08-17 04:24:11",
      courseId: "1",
      course: "Bahasa Indonesia",
      isFilled: "0",
    ),
  ],
);
