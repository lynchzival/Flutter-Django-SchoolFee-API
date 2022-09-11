import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_project/Controllers/student_controller.dart';
import 'package:school_project/Views/Students/student_detail.dart';

import '../../Models/student.dart';

class StudentEdit extends StatefulWidget {
  const StudentEdit({Key? key, required this.student}) : super(key: key);
  final Student student;

  @override
  State<StudentEdit> createState() => _StudentEditState();
}

class _StudentEditState extends State<StudentEdit> {
  final _addFormKey = GlobalKey<FormState>();
  int id = 0;
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  var studentController = Get.put(StudentController());

  @override
  void initState() {
    id = widget.student.id;
    _nameController.text = widget.student.name;
    _contactController.text = widget.student.contact;
    _emailController.text = widget.student.email;
    _addressController.text = widget.student.address;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit ${widget.student.name}"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
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
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://avatars.dicebear.com/api/initials/${widget.student.name}.png?chars=1"),
                    ),
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
                      child: const Text('Save'),
                      onPressed: () {
                        String name = _nameController.text;
                        String contact = _contactController.text;
                        String email = _emailController.text;
                        String address = _addressController.text;
                        var student = Student(
                            id: id,
                            email: email,
                            name: name,
                            contact: contact,
                            address: address);
                        var body = jsonEncode(student.toJson());
                        studentController.updateStudentById(
                            body, widget.student.id);
                        Get.back();
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
