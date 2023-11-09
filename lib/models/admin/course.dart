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
  String? claassId;
  String? teacher;
  String? teacherId;
  String? semester;
  String? semesterId;

  Course({
    required this.id,
    required this.name,
    required this.claass,
    this.claassId,
    this.teacher,
    this.teacherId,
    this.semester,
    this.semesterId,
  }) {
    claassId ??= "";
    teacher ??= "";
    teacherId ??= "";
    semester ??= "";
    semesterId ??= "";
  }

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
