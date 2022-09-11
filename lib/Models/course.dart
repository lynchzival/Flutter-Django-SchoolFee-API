// To parse this JSON data, do
//
//     final course = courseFromJson(jsonString);

import 'dart:convert';

List<Course> courseFromJson(String str) =>
    List<Course>.from(json.decode(str).map((x) => Course.fromJson(x)));

String courseToJson(List<Course> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Course {
  Course({
    required this.id,
    required this.fees,
    required this.name,
    required this.courseDesc,
    required this.level,
    required this.totalAmount,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  List<Fee> fees;
  String name;
  String courseDesc;
  String level;
  double totalAmount;
  DateTime createdAt;
  DateTime updatedAt;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        fees: List<Fee>.from(json["fees"].map((x) => Fee.fromJson(x))),
        name: json["name"],
        courseDesc: json["course_desc"],
        level: json["level"],
        totalAmount: json["total_amount"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fees": List<dynamic>.from(fees.map((x) => x.toJson())),
        "name": name,
        "course_desc": courseDesc,
        "level": level,
        "total_amount": totalAmount,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Fee {
  Fee({
    required this.id,
    required this.feeDesc,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
    required this.course,
  });

  int id;
  String feeDesc;
  double amount;
  DateTime createdAt;
  DateTime updatedAt;
  int course;

  factory Fee.fromJson(Map<String, dynamic> json) => Fee(
        id: json["id"],
        feeDesc: json["fee_desc"],
        amount: json["amount"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        course: json["course"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fee_desc": feeDesc,
        "amount": amount,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "course": course,
      };
}
