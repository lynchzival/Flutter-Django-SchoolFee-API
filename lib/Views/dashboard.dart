import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_project/Controllers/enroll_controller.dart';
import 'package:school_project/Controllers/student_controller.dart';
import 'package:school_project/Views/Courses/course_insert.dart';
import 'package:school_project/Views/Enrolls/enroll_insert.dart';
import 'package:school_project/Views/Payments/payment_insert.dart';
import 'package:school_project/Views/Students/student_insert.dart';
import 'package:school_project/Widgets/sidebar.dart';

import '../Controllers/course_controller.dart';
import '../Controllers/payment_controller.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var studentController = Get.put(StudentController());
  var enrollController = Get.put(EnrollController());
  var courseController = Get.put(CourseController());
  var paymentController = Get.put(PaymentController());

  Future _refresh() async {
    await studentController.onInit();
    await enrollController.onInit();
    await courseController.onInit();
    await paymentController.onInit();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: FutureBuilder(
        future: _refresh(),
        builder: (context, snapshot) {
          return (studentController.studentList.isNotEmpty &&
                  enrollController.enrollList.isNotEmpty &&
                  courseController.courseList.isNotEmpty &&
                  paymentController.paymentList.isNotEmpty)
              ? _stat()
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  Widget _stat() {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Create",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                ),
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => const StudentInsert());
                                    },
                                    child: Column(
                                      children: const [
                                        Icon(
                                          Icons.account_circle,
                                          color: Colors.blueAccent,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          "Student",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                              color: Color(0xff67727d)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => const EnrollInsert());
                                    },
                                    child: Column(
                                      children: const [
                                        Icon(
                                          Icons.school,
                                          color: Colors.blueAccent,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          "Enrollment",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                              color: Color(0xff67727d)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => const CourseInsert());
                                    },
                                    child: Column(
                                      children: const [
                                        Icon(
                                          Icons.menu_book,
                                          color: Colors.blueAccent,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          "Course",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                              color: Color(0xff67727d)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => const PaymentInsert());
                                    },
                                    child: Column(
                                      children: const [
                                        Icon(
                                          Icons.monetization_on,
                                          color: Colors.blueAccent,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          "Payment",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                              color: Color(0xff67727d)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
                              "TOTAL STUDENTS",
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
                              Icons.account_circle,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
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
                                  "ENROLLS",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: Color(0xff67727d)),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  enrollController.enrollList.length.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: 40,
                              height: 40,
                              child: const Center(
                                child: Icon(
                                  Icons.school,
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
                    Container(
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
                                  "COURSES",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: Color(0xff67727d)),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  courseController.courseList.length.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: 40,
                              height: 40,
                              child: const Center(
                                child: Icon(
                                  Icons.menu_book,
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
                  ],
                ),
                const SizedBox(height: 20),
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
                              "TOTAL PAYMENTS",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Color(0xff67727d)),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              paymentController.paymentList.length.toString(),
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
                              Icons.attach_money,
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
              ],
            ),
          ),
        ));
  }
}
