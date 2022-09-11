import 'dart:convert';

import 'package:get/get.dart';
import 'package:school_project/Controllers/user_controller.dart';
import 'package:school_project/Models/course.dart';
import 'package:http/http.dart' as http;
import 'package:school_project/Properties.dart';
import 'package:flutter/material.dart';

class CourseController extends GetxController {
  var courseList = <Course>[].obs;

  @override
  Future onInit() async {
    super.onInit();
    var courses = await getCourses();
    courseList.value = courses;
    update();
  }

  Future<List<Course>> getCourses() async {
    var url = Uri.parse("${Properties.BASE_URL}/api/v1/courses/");
    var response =
        await http.get(url, headers: await UserController.getHeader());
    if (response.statusCode == 200) {
      var courses = json.decode(response.body) as List;
      return courses.map((course) => Course.fromJson(course)).toList();
    } else if (response.statusCode == 401) {
      return await UserController.refreshToken();
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
}
