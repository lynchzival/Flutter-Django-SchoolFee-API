import 'dart:convert';

import 'package:get/get.dart';
import 'package:school_project/Controllers/user_controller.dart';
import 'package:http/http.dart' as http;
import 'package:school_project/Models/payment.dart';
import 'package:school_project/Properties.dart';
import 'package:flutter/material.dart';

class PaymentController extends GetxController {
  var paymentList = <Payment>[].obs;

  @override
  Future onInit() async {
    super.onInit();
    var payments = await getPayments();
    paymentList.value = payments;
    update();
  }

  Future<List<Payment>> getPayments() async {
    var url = Uri.parse("${Properties.BASE_URL}/api/v1/payments/");
    var response =
        await http.get(url, headers: await UserController.getHeader());
    if (response.statusCode == 200) {
      var payments = json.decode(response.body) as List;
      return payments.map((payment) => Payment.fromJson(payment)).toList();
    } else if (response.statusCode == 401) {
      await UserController.refreshToken();
      return await getPayments();
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

  Future deletePaymentById(int id) async {
    var url = Uri.parse("${Properties.BASE_URL}/api/v1/payments/$id/delete/");
    var response =
        await http.delete(url, headers: await UserController.getHeader());
    if (response.statusCode == 200) {
      Get.showSnackbar(
        const GetSnackBar(
          title: "Success",
          message: "Payment Deleted",
          isDismissible: true,
          backgroundColor: Colors.blue,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          title: "Error",
          message: "Failed to delete payment",
          isDismissible: true,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      throw Exception('Error delete:${response.statusCode}');
    }
  }
}
