import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_project/Views/Courses/course_insert.dart';
import 'package:school_project/Widgets/sidebar.dart';

import '../../Controllers/course_controller.dart';

class CourseList extends StatefulWidget {
  const CourseList({Key? key}) : super(key: key);

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  var courseController = Get.put(CourseController());

  Future _refresh() async {
    await courseController.onInit();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        title: const Text('Courses'),
      ),
      body: FutureBuilder(
        future: _refresh(),
        builder: (context, snapshot) {
          return courseController.courseList.isNotEmpty
              ? _list()
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const CourseInsert());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _list() {
    return Obx(
      () => Padding(
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
                          "TOTAL COURSES",
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
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                  itemCount: courseController.courseList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 3.0,
                              offset: const Offset(0.0, 3.0),
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, top: 20, bottom: 20),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${courseController.courseList[index].totalAmount.toString()}\$",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          color: Color(0xff67727d)),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "${courseController.courseList[index].name} ${courseController.courseList[index].level}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 35,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 40,
                                  height: 40,
                                  child: const Center(
                                    child: Icon(
                                      Icons.book,
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
                            const SizedBox(height: 10),
                            const Divider(),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                for (var i = 0;
                                    i <
                                        courseController
                                            .courseList[index].fees.length;
                                    i++)
                                  Column(
                                    children: [
                                      const Icon(
                                        Icons.category,
                                        color: Colors.blueAccent,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        courseController
                                            .courseList[index].fees[i].feeDesc,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: Color(0xff67727d)),
                                      ),
                                    ],
                                  ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
