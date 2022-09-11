// To parse this JSON data, do
//
//     final enroll = enrollFromJson(jsonString);

import 'dart:convert';

List<Enroll> enrollFromJson(String str) =>
    List<Enroll>.from(json.decode(str).map((x) => Enroll.fromJson(x)));

String enrollToJson(List<Enroll> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Enroll {
  Enroll({
    required this.id,
    required this.paid,
    required this.balance,
    required this.payments,
    required this.totalFee,
    required this.createdAt,
    required this.updatedAt,
    required this.studentId,
    required this.courseId,
  });

  int id;
  double paid;
  double balance;
  List<Payment> payments;
  double totalFee;
  DateTime createdAt;
  DateTime updatedAt;
  StudentId studentId;
  CourseId courseId;

  factory Enroll.fromJson(Map<String, dynamic> json) => Enroll(
        id: json["id"],
        paid: json["paid"] ?? 0,
        balance: json["balance"],
        payments: List<Payment>.from(
            json["payments"].map((x) => Payment.fromJson(x))),
        totalFee: json["total_fee"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        studentId: StudentId.fromJson(json["student_id"]),
        courseId: CourseId.fromJson(json["course_id"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "paid": paid,
        "balance": balance,
        "payments": List<dynamic>.from(payments.map((x) => x.toJson())),
        "total_fee": totalFee,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "student_id": studentId.toJson(),
        "course_id": courseId.toJson(),
      };
}

class CourseId {
  CourseId({
    required this.id,
    required this.name,
    required this.courseDesc,
    required this.level,
    required this.totalAmount,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String courseDesc;
  String level;
  double totalAmount;
  DateTime createdAt;
  DateTime updatedAt;

  factory CourseId.fromJson(Map<String, dynamic> json) => CourseId(
        id: json["id"],
        name: json["name"],
        courseDesc: json["course_desc"],
        level: json["level"],
        totalAmount: json["total_amount"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "course_desc": courseDesc,
        "level": level,
        "total_amount": totalAmount,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Payment {
  Payment({
    required this.id,
    required this.amount,
    required this.dateCreated,
    required this.dateUpdated,
    required this.createdBy,
    required this.remarks,
  });

  int id;
  double amount;
  DateTime dateCreated;
  DateTime dateUpdated;
  CreatedBy createdBy;
  String remarks;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        amount: double.parse(json["amount"]),
        dateCreated: DateTime.parse(json["date_created"]),
        dateUpdated: DateTime.parse(json["date_updated"]),
        createdBy: CreatedBy.fromJson(json["created_by"]),
        remarks: json["remarks"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "date_created": dateCreated.toIso8601String(),
        "date_updated": dateUpdated.toIso8601String(),
        "created_by": createdBy.toJson(),
        "remarks": remarks,
      };
}

class CreatedBy {
  CreatedBy({
    required this.id,
    required this.password,
    required this.lastLogin,
    required this.isSuperuser,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isStaff,
    required this.isActive,
    required this.dateJoined,
    required this.groups,
    required this.userPermissions,
  });

  int id;
  String password;
  DateTime lastLogin;
  bool isSuperuser;
  String username;
  String firstName;
  String lastName;
  String email;
  bool isStaff;
  bool isActive;
  DateTime dateJoined;
  List<dynamic> groups;
  List<dynamic> userPermissions;

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["id"],
        password: json["password"],
        lastLogin: DateTime.parse(json["last_login"]),
        isSuperuser: json["is_superuser"],
        username: json["username"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        isStaff: json["is_staff"],
        isActive: json["is_active"],
        dateJoined: DateTime.parse(json["date_joined"]),
        groups: List<dynamic>.from(json["groups"].map((x) => x)),
        userPermissions:
            List<dynamic>.from(json["user_permissions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "password": password,
        "last_login": lastLogin.toIso8601String(),
        "is_superuser": isSuperuser,
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "is_staff": isStaff,
        "is_active": isActive,
        "date_joined": dateJoined.toIso8601String(),
        "groups": List<dynamic>.from(groups.map((x) => x)),
        "user_permissions": List<dynamic>.from(userPermissions.map((x) => x)),
      };
}

class StudentId {
  StudentId({
    required this.id,
    required this.name,
    required this.contact,
    required this.address,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String contact;
  String address;
  String email;
  DateTime createdAt;
  DateTime updatedAt;

  factory StudentId.fromJson(Map<String, dynamic> json) => StudentId(
        id: json["id"],
        name: json["name"],
        contact: json["contact"],
        address: json["address"],
        email: json["email"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "contact": contact,
        "address": address,
        "email": email,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
