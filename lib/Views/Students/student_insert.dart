import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_project/Controllers/student_controller.dart';

import '../../Models/student.dart';

class StudentInsert extends StatefulWidget {
  const StudentInsert({Key? key}) : super(key: key);

  @override
  State<StudentInsert> createState() => _StudentInsertState();
}

class _StudentInsertState extends State<StudentInsert> {
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  var studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Insert"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.01),
                  spreadRadius: 10,
                  blurRadius: 3,
                  // changes position of shadow
                ),
              ]),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        width: 40,
                        height: 40,
                        child: const Center(
                          child: Icon(
                            Icons.account_circle,
                            color: Colors.white,
                          ),
                        ),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: _contactController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contact',
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Address',
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 35,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                      child: const Text('Insert'),
                      onPressed: () {
                        String name = _nameController.text;
                        String contact = _contactController.text;
                        String email = _emailController.text;
                        String address = _addressController.text;
                        var student = Student(
                            id: 0,
                            email: email,
                            name: name,
                            contact: contact,
                            address: address);
                        var body = jsonEncode(student.toJson());
                        studentController.insertStudent(body);
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
