import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_project/Models/user.dart';
import 'package:http/http.dart' as http;
import 'package:school_project/Views/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Views/login.dart';
import '../properties.dart';

class UserController extends GetxController {
  Future logIn(String body) async {
    var myHeader = {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };
    var url = Uri.parse(
      "${Properties.BASE_URL}/api/token/",
    );
    final response = await http.post(url, body: body, headers: myHeader);
    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final access = userFromJson(response.body).access;
      final refresh = userFromJson(response.body).refresh;
      prefs.setString("access", access);
      prefs.setString("refresh", refresh);
      Get.offAll(() => const Dashboard());
    } else {
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: jsonDecode(response.body)['detail'],
          isDismissible: true,
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
      throw Exception(
          'Error user login:${jsonDecode(response.body)['detail']}');
    }
  }

  Future logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("access");
    prefs.remove("refresh");
  }

  static Future refreshToken() async {
    var myHeader = {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse(
      "${Properties.BASE_URL}/api/token/refresh/",
    );
    var refresh1 = prefs.getString("refresh");
    var user = User(
        refresh: refresh1.toString(), access: "", username: "", password: "");
    var body = jsonEncode(user.toJson());
    final response = await http.post(url, body: body, headers: myHeader);
    if (response.statusCode == 200) {
      var access = jsonDecode(response.body);
      prefs.setString("access", access["access"]);
    } else {
      throw Exception('Error refresh :${response.toString()}');
    }
  }

  static getHeader() async {
    var prefs = await SharedPreferences.getInstance();
    var access = prefs.getString("access");
    var myHeader = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $access'
    };
    return myHeader;
  }
}
