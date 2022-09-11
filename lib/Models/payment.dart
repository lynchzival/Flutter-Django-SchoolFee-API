import 'dart:convert';

List<Payment> paymentFromJson(String str) =>
    List<Payment>.from(json.decode(str).map((x) => Payment.fromJson(x)));

String paymentToJson(List<Payment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
  String amount;
  DateTime dateCreated;
  DateTime dateUpdated;
  CreatedBy createdBy;
  String remarks;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        amount: json["amount"],
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
