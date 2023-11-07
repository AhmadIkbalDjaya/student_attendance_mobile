import 'dart:convert';

Claass claassFromJson(String str) => Claass.fromJson(json.decode(str)['data']);

String claassToJson(Claass data) => json.encode(data.toJson());

List<Claass> claassesFromJson(String str) =>
    List<Claass>.from(json.decode(str)['data'].map((x) => Claass.fromJson(x)));

String claassesToJson(List<Claass> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Claass {
  final int id;
  final String majorId;
  final String major;
  final String level;
  final String name;

  Claass({
    required this.id,
    required this.majorId,
    required this.major,
    required this.level,
    required this.name,
  });

  factory Claass.fromJson(Map<String, dynamic> json) => Claass(
        id: json["id"],
        majorId: json["major_id"],
        major: json["major"],
        level: json["level"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "major_id": majorId,
        "major": major,
        "level": level,
        "name": name,
      };
}
