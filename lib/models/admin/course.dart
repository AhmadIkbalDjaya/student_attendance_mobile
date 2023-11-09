import 'dart:convert';

Course courseFromJson(String str) => Course.fromJson(json.decode(str)["data"]);

String courseToJson(Course data) => json.encode(data.toJson());

List<Course> coursesFromJson(String str) =>
    List<Course>.from(json.decode(str)["data"].map((x) => Course.fromJson(x)));

String coursesToJson(List<Course> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Course {
  final int id;
  final String name;
  final String claass;
  final String claassId;
  final String teacher;
  final String teacherId;
  final String semester;
  final String semesterId;

  Course({
    required this.id,
    required this.name,
    required this.claass,
    required this.claassId,
    required this.teacher,
    required this.teacherId,
    required this.semester,
    required this.semesterId,
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
      };
}
