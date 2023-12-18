// To parse this JSON data, do
//
//     final courseRecap = courseRecapFromJson(jsonString);

import 'dart:convert';

import 'package:student_attendance/models/teacher/course.dart';

CourseRecap courseRecapFromJson(String str) =>
    CourseRecap.fromJson(json.decode(str)['data']);

String courseRecapToJson(CourseRecap data) => json.encode(data.toJson());

class CourseRecap {
  final Course course;
  final List<StudentsRecap> studentsRecap;

  CourseRecap({
    required this.course,
    required this.studentsRecap,
  });

  factory CourseRecap.fromJson(Map<String, dynamic> json) => CourseRecap(
        course: Course.fromJson(json["course"]),
        studentsRecap: List<StudentsRecap>.from(
            json["students_recap"].map((x) => StudentsRecap.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "course": course.toJson(),
        "students_recap":
            List<dynamic>.from(studentsRecap.map((x) => x.toJson())),
      };
}

class StudentsRecap {
  final String name;
  final String nis;
  final String gender;
  final int hCount;
  final int sCount;
  final int iCount;
  final int aCount;

  StudentsRecap({
    required this.name,
    required this.nis,
    required this.gender,
    required this.hCount,
    required this.sCount,
    required this.iCount,
    required this.aCount,
  });

  factory StudentsRecap.fromJson(Map<String, dynamic> json) => StudentsRecap(
        name: json["name"],
        nis: json["nis"],
        gender: json["gender"],
        hCount: json["h_count"],
        sCount: json["s_count"],
        iCount: json["i_count"],
        aCount: json["a_count"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "nis": nis,
        "gender": gender,
        "h_count": hCount,
        "s_count": sCount,
        "i_count": iCount,
        "a_count": aCount,
      };
}

CourseRecap dummyCourseRecap = CourseRecap(
  course: dummyCourse,
  studentsRecap: [
    StudentsRecap(
      name: "Nama Siswa 1",
      nis: "12345678",
      gender: "male",
      hCount: 5,
      sCount: 5,
      iCount: 5,
      aCount: 5,
    ),
    StudentsRecap(
      name: "Nama Siswa 1",
      nis: "12345678",
      gender: "male",
      hCount: 5,
      sCount: 5,
      iCount: 5,
      aCount: 5,
    ),
    StudentsRecap(
      name: "Nama Siswa 1",
      nis: "12345678",
      gender: "male",
      hCount: 5,
      sCount: 5,
      iCount: 5,
      aCount: 5,
    ),
    StudentsRecap(
      name: "Nama Siswa 1",
      nis: "12345678",
      gender: "male",
      hCount: 5,
      sCount: 5,
      iCount: 5,
      aCount: 5,
    ),
    StudentsRecap(
      name: "Nama Siswa 1",
      nis: "12345678",
      gender: "male",
      hCount: 5,
      sCount: 5,
      iCount: 5,
      aCount: 5,
    ),
  ],
);
