import 'dart:convert';

IdName idNameFromJson(String str) => IdName.fromJson(json.decode(str)['data']);

List<IdName> idNamesFromJson(String str) =>
    List<IdName>.from(json.decode(str)['data'].map((x) => IdName.fromJson(x)));

class IdName {
  final int id;
  final String name;
  IdName({
    required this.id,
    required this.name,
  });

  factory IdName.fromJson(Map<String, dynamic> json) => IdName(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
