import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_project/Views/Courses/course_list.dart';
import 'package:school_project/Views/Enrolls/enroll_list.dart';
import 'package:school_project/Views/Students/student_list.dart';
import 'package:school_project/Views/dashboard.dart';

import '../Controllers/user_controller.dart';
import '../Views/Payments/payment_list.dart';
import '../Views/login.dart';

class SideBar extends StatelessWidget {
  SideBar({Key? key}) : super(key: key);

  var userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            child: Center(
              child: Icon(
                Icons.school,
                size: 70,
                color: Colors.black,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              // image: DecorationImage(
              //   fit: BoxFit.fill,
              //   image: AssetImage('assets/images/cover.jpg'),
              // ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () => {Get.to(() => const Dashboard())},
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Students'),
            onTap: () => {Get.to(() => const StudentList())},
          ),
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('Enrollments'),
            onTap: () => {Get.to(() => const EnrollList())},
          ),
          ListTile(
            leading: const Icon(Icons.menu_book),
            title: const Text('Courses'),
            onTap: () => {Get.to(() => const CourseList())},
          ),
          ListTile(
            leading: const Icon(Icons.monetization_on),
            title: const Text('Payments'),
            onTap: () => {Get.to(() => const PaymentList())},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () => {
              userController.logout(),
              Get.offAll(() => const Login()),
            },
          ),
        ],
      ),
    );
  }
}
