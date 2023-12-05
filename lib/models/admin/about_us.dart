import 'dart:convert';

AboutUs aboutUsFromJson(String str) =>
    AboutUs.fromJson(json.decode(str)["data"]);

List<AboutUs> aboutUsesFromJson(String str) => List<AboutUs>.from(
    json.decode(str)["data"].map((x) => AboutUs.fromJson(x)));

class AboutUs {
  final int id;
  final String name;
  final String position;
  final String email;
  final String phone;
  AboutUs({
    required this.id,
    required this.name,
    required this.position,
    required this.email,
    required this.phone,
  });

  factory AboutUs.fromJson(Map<String, dynamic> json) => AboutUs(
        id: json["id"],
        name: json["name"],
        position: json["position"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "position": position,
        "email": email,
        "phone": phone,
      };
}

List<AboutUs> dummtAboutUses = [
  AboutUs(
    id: 1,
    name: "Nama Lengkap",
    position: "Jabatan / Posisi",
    email: "email@gmail.com",
    phone: "081234567890",
  ),
  AboutUs(
    id: 2,
    name: "Nama Lengkap",
    position: "Jabatan / Posisi",
    email: "email@gmail.com",
    phone: "081234567890",
  ),
  AboutUs(
    id: 3,
    name: "Nama Lengkap",
    position: "Jabatan / Posisi",
    email: "email@gmail.com",
    phone: "081234567890",
  ),
  AboutUs(
    id: 4,
    name: "Nama Lengkap",
    position: "Jabatan / Posisi",
    email: "email@gmail.com",
    phone: "081234567890",
  ),
  AboutUs(
    id: 5,
    name: "Nama Lengkap",
    position: "Jabatan / Posisi",
    email: "email@gmail.com",
    phone: "081234567890",
  ),
];
