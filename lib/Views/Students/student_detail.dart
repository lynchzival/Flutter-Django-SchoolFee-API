import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_project/Models/student.dart';
import 'package:school_project/Views/Students/student_edit.dart';

import '../../Controllers/student_controller.dart';

class StudentDetail extends StatefulWidget {
  const StudentDetail({Key? key, required this.student}) : super(key: key);

  final Student student;

  @override
  State<StudentDetail> createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentDetail> {
  var studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.student.name),
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Icon(Icons.call, color: Color(0xff67727d)),
                            const SizedBox(width: 5),
                            Text(
                              widget.student.contact,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Color(0xff67727d)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          widget.student.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://avatars.dicebear.com/api/initials/${widget.student.name}.png?chars=1"),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.student.address,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: Color(0xff67727d)),
                  ),
                ),
                const SizedBox(height: 35),
                ButtonBar(
                  buttonPadding: const EdgeInsetsDirectional.only(start: 0),
                  alignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: const [
                          Icon(Icons.edit, color: Colors.white),
                          SizedBox(width: 5),
                          Text(
                            "Edit",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                      onPressed: () {
                        _navigateToEditScreen(context, widget.student);
                      },
                    ),
                    const SizedBox(width: 15),
                    ElevatedButton(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: const [
                          Icon(Icons.delete, color: Colors.white),
                          SizedBox(width: 5),
                          Text(
                            "Delete",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.redAccent),
                      ),
                      onPressed: () {
                        _confirmDialog();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _navigateToEditScreen(BuildContext context, Student student) async {
    Get.to(StudentEdit(student: student));
  }

  Future<void> _confirmDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning!'.toUpperCase()),
          content: SingleChildScrollView(
            child: ListBody(
              children: const [
                Text('Are you sure want delete this item?'),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: const [
                  Icon(Icons.done, color: Colors.white),
                  SizedBox(width: 5),
                  Text(
                    "Yes",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: Colors.white),
                  ),
                ],
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.redAccent),
              ),
              onPressed: () {
                studentController.deleteStudentById(widget.student.id);
                Get.back();
                Get.back();
              },
            ),
            ElevatedButton(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: const [
                  Icon(Icons.close, color: Colors.white),
                  SizedBox(width: 5),
                  Text(
                    "No",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: Colors.white),
                  ),
                ],
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey),
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}
