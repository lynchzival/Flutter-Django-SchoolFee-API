import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_project/Controllers/user_controller.dart';
import 'package:school_project/Models/student.dart';
import 'package:school_project/Properties.dart';

class StudentController extends GetxController {
  var studentList = <Student>[].obs;

  @override
  Future onInit() async {
    super.onInit();
    var students = await getStudentAll();
    studentList.value = students;
    update();
  }

  Future<List<Student>> getStudentAll() async {
    var url = Uri.parse("${Properties.BASE_URL}/api/v1/students/");
    var response =
        await http.get(url, headers: await UserController.getHeader());
    if (response.statusCode == 200) {
      final List<Student> list = studentFromJson(response.body);
      return list;
    } else if (response.statusCode == 401) {
      await UserController.refreshToken();
      return await getStudentAll();
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          title: "Error",
          message: "Failed to load API",
          isDismissible: true,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      throw Exception("Error :${response.toString()}");
    }
  }

  Future updateStudentById(String body, int id) async {
    var url = Uri.parse(
      "${Properties.BASE_URL}/api/v1/students/$id/update/",
    );
    final response = await http.put(url,
        body: body, headers: await UserController.getHeader());
    if (response.statusCode == 200) {
      Get.showSnackbar(
        const GetSnackBar(
          title: "Success",
          message: "Student Updated",
          isDismissible: true,
          backgroundColor: Colors.blue,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          title: "Error",
          message: "Failed to update student",
          isDismissible: true,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future deleteStudentById(int id) async {
    var url = Uri.parse("${Properties.BASE_URL}/api/v1/students/$id/delete/");
    var response =
        await http.delete(url, headers: await UserController.getHeader());
    if (response.statusCode == 204) {
      Get.showSnackbar(
        const GetSnackBar(
          title: "Success",
          message: "Student Deleted",
          isDismissible: true,
          backgroundColor: Colors.blue,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          title: "Error",
          message: "Failed to delete student",
          isDismissible: true,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future insertStudent(String body) async {
    var url = Uri.parse(
      "${Properties.BASE_URL}/api/v1/students/store/",
    );
    final response = await http.post(url,
        body: body, headers: await UserController.getHeader());
    if (response.statusCode == 201) {
      Get.showSnackbar(
        const GetSnackBar(
          title: "Success",
          message: "Student Added",
          isDismissible: true,
          backgroundColor: Colors.blue,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          title: "Error",
          message: "Failed to add student",
          isDismissible: true,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
