import 'dart:convert';

List<Student> studentFromJson(String str) =>
    List<Student>.from(json.decode(str).map((x) => Student.fromJson(x)));

String studentToJson(List<Student> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Student {
  Student({
    required this.id,
    required this.email,
    required this.name,
    required this.contact,
    required this.address,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String email;
  String name;
  String contact;
  String address;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        contact: json["contact"],
        address: json["address"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "contact": contact,
        "address": address,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
