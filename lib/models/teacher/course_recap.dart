// To parse this JSON data, do
//
//     final courseRecap = courseRecapFromJson(jsonString);

import 'dart:convert';

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

class Course {
  final int id;
  final String claass;
  final String courseName;
  final String semester;
  final int attendanceCount;

  Course({
    required this.id,
    required this.claass,
    required this.courseName,
    required this.semester,
    required this.attendanceCount,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        claass: json["claass"],
        courseName: json["course_name"],
        semester: json["semester"],
        attendanceCount: json["attendance_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "claass": claass,
        "course_name": courseName,
        "semester": semester,
        "attendance_count": attendanceCount,
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
  course: Course(
      id: 1,
      claass: "10 IPA 1",
      courseName: "Bahasa Indonesia",
      semester: "(Ganjil) 2020/2021",
      attendanceCount: 16),
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
