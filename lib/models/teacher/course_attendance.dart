// To parse this JSON data, do
//
//     final courseAttendance = courseAttendanceFromJson(jsonString);

import 'dart:convert';

CourseAttendance courseAttendanceFromJson(String str) =>
    CourseAttendance.fromJson(json.decode(str)['data']);

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
  final String isFilled;

  Attendance({
    required this.id,
    required this.title,
    required this.isFilled,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        id: json["id"],
        title: json["title"],
        isFilled: json["is_filled"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "is_filled": isFilled,
      };
}

class Course {
  final int id;
  final String name;
  final String claass;
  final String semester;

  Course({
    required this.id,
    required this.name,
    required this.claass,
    required this.semester,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        name: json["name"],
        claass: json["claass"],
        semester: json["semester"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "claass": claass,
        "semester": semester,
      };
}

CourseAttendance dummyCourseAttendance = CourseAttendance(
  course: Course(
      id: 1,
      name: "Bahasa Indonesia",
      claass: "10 IPA 1",
      semester: "(Genap) 2020 /2021"),
  attendances: [
    Attendance(
      id: 1,
      title: "Pertemuan 1",
      isFilled: "0",
    ),
    Attendance(
      id: 2,
      title: "Pertemuan 2",
      isFilled: "0",
    ),
    Attendance(
      id: 3,
      title: "Pertemuan 3",
      isFilled: "0",
    ),
  ],
);
