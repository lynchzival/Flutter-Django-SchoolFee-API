import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_project/Controllers/student_controller.dart';
import 'package:school_project/Models/student.dart';
import 'package:school_project/Views/Students/student_detail.dart';
import 'package:school_project/Views/Students/student_insert.dart';
import 'package:school_project/Widgets/sidebar.dart';

class StudentList extends StatefulWidget {
  const StudentList({Key? key}) : super(key: key);
  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  var studentController = Get.put(StudentController());

  Future _refresh() async {
    await studentController.onInit();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    studentController.onInit();
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        title: const Text('Students'),
      ),
      body: FutureBuilder(
        future: _refresh(),
        builder: (context, snapshot) {
          return studentController.studentList.isNotEmpty
              ? _list()
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const StudentInsert());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _list() {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: double.infinity,
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
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 20, bottom: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "STUDENTS (REGISTERED)",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Color(0xff67727d)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            studentController.studentList.length.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                          )
                        ],
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        child: const Center(
                          child: Icon(
                            Icons.people,
                            color: Colors.white,
                          ),
                        ),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                    itemCount: studentController.studentList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: InkWell(
                          onTap: () {
                            Get.to(
                              StudentDetail(
                                  student:
                                      studentController.studentList[index]),
                            );
                          },
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(15),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://avatars.dicebear.com/api/initials/${studentController.studentList[index].name}.png?chars=1"),
                            ),
                            title:
                                Text(studentController.studentList[index].name),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ));
  }
}
