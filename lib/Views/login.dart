import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/user_controller.dart';
import '../Models/User.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Icon(Icons.account_circle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            Container(
              width: 100,
              height: 100,
              child: const Center(
                child: Icon(
                  Icons.key,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 35),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                child: const Text('Login'),
                onPressed: () {
                  String username = nameController.text;
                  String password = passwordController.text;
                  // var user = User(
                  //     refresh: "",
                  //     access: "",
                  //     username: "lynchzival",
                  //     password: "089666002");
                  // var body = jsonEncode(user.toJson());
                  // userController.logIn(body);
                  if (username.isNotEmpty && password.isNotEmpty) {
                    var user = User(
                        refresh: "",
                        access: "",
                        username: username,
                        password: password);
                    var body = jsonEncode(user.toJson());
                    userController.logIn(body);
                  } else {
                    Get.showSnackbar(
                      const GetSnackBar(
                        title: "Error",
                        message: "Username or password is empty",
                        isDismissible: true,
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
