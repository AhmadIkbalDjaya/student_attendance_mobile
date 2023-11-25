// To parse this JSON data, do
//
//     final teacherCourse = teacherCourseFromJson(jsonString);

import 'dart:convert';

List<TeacherCourse> teacherCourseFromJson(String str) =>
    List<TeacherCourse>.from(
        json.decode(str)['data'].map((x) => TeacherCourse.fromJson(x)));

String teacherCourseToJson(List<TeacherCourse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeacherCourse {
  final String major;
  final List<Level> levels;

  TeacherCourse({
    required this.major,
    required this.levels,
  });

  factory TeacherCourse.fromJson(Map<String, dynamic> json) => TeacherCourse(
        major: json["major"],
        levels: List<Level>.from(json["levels"].map((x) => Level.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "major": major,
        "levels": List<dynamic>.from(levels.map((x) => x.toJson())),
      };
}

class Level {
  final String level;
  final List<Claass> claasses;

  Level({
    required this.level,
    required this.claasses,
  });

  factory Level.fromJson(Map<String, dynamic> json) => Level(
        level: json["level"],
        claasses:
            List<Claass>.from(json["claasses"].map((x) => Claass.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "level": level,
        "claasses": List<dynamic>.from(claasses.map((x) => x.toJson())),
      };
}

class Claass {
  final String claassName;
  final List<Course> courses;

  Claass({
    required this.claassName,
    required this.courses,
  });

  factory Claass.fromJson(Map<String, dynamic> json) => Claass(
        claassName: json["claass_name"],
        courses:
            List<Course>.from(json["courses"].map((x) => Course.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "claass_name": claassName,
        "courses": List<dynamic>.from(courses.map((x) => x.toJson())),
      };
}

class Course {
  final int id;
  final String courseName;

  Course({
    required this.id,
    required this.courseName,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        courseName: json["course_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "course_name": courseName,
      };
}

TeacherCourse dummyTeacherCourse = TeacherCourse(
  major: "IPA",
  levels: [
    Level(
      level: "10",
      claasses: [
        Claass(
          claassName: "10 IPA 1",
          courses: [
            Course(id: 1, courseName: "Introduction to Physics"),
            Course(id: 2, courseName: "Newtonian Mechanics"),
          ],
        ),
        Claass(
          claassName: "10 IPA 2",
          courses: [
            Course(id: 1, courseName: "Introduction to Physics"),
            Course(id: 2, courseName: "Newtonian Mechanics"),
          ],
        ),
        Claass(
          claassName: "10 IPA 3",
          courses: [
            Course(id: 1, courseName: "Introduction to Physics"),
            Course(id: 2, courseName: "Newtonian Mechanics"),
          ],
        ),
      ],
    ),
    Level(
      level: "11",
      claasses: [
        Claass(
          claassName: "11 IPA 1",
          courses: [
            Course(id: 1, courseName: "Introduction to Physics"),
            Course(id: 2, courseName: "Newtonian Mechanics"),
          ],
        ),
        Claass(
          claassName: "11 IPA 2",
          courses: [
            Course(id: 1, courseName: "Introduction to Physics"),
            Course(id: 2, courseName: "Newtonian Mechanics"),
          ],
        ),
        Claass(
          claassName: "11 IPA 3",
          courses: [
            Course(id: 1, courseName: "Introduction to Physics"),
            Course(id: 2, courseName: "Newtonian Mechanics"),
          ],
        ),
      ],
    ),
  ],
);
