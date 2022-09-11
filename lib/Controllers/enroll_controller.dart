import 'dart:convert';

import 'package:get/get.dart';
import 'package:school_project/Controllers/user_controller.dart';
import 'package:http/http.dart' as http;
import 'package:school_project/Models/enroll.dart';
import 'package:school_project/Properties.dart';
import 'package:flutter/material.dart';

class EnrollController extends GetxController {
  var enrollList = <Enroll>[].obs;

  @override
  Future onInit() async {
    super.onInit();
    var enrolls = await getEnrolls();
    enrollList.value = enrolls;
    update();
  }

  Future<List<Enroll>> getEnrolls() async {
    var url = Uri.parse("${Properties.BASE_URL}/api/v1/enrolls/");
    var response =
        await http.get(url, headers: await UserController.getHeader());
    if (response.statusCode == 200) {
      var enrolls = json.decode(response.body) as List;
      try {
        return enrolls.map((enroll) => Enroll.fromJson(enroll)).toList();
      } catch (e) {
        print(e);
        return [];
      }
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
