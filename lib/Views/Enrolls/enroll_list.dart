import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_project/Views/Enrolls/enroll_detail.dart';
import 'package:school_project/Views/Enrolls/enroll_insert.dart';
import 'package:school_project/Widgets/sidebar.dart';

import '../../Controllers/enroll_controller.dart';

class EnrollList extends StatefulWidget {
  const EnrollList({Key? key}) : super(key: key);

  @override
  State<EnrollList> createState() => _EnrollListState();
}

class _EnrollListState extends State<EnrollList> {
  var enrollController = Get.put(EnrollController());

  Future _refresh() async {
    await enrollController.onInit();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        title: const Text('Enrollments'),
      ),
      body: FutureBuilder(
        future: _refresh(),
        builder: (context, snapshot) {
          return enrollController.enrollList.isNotEmpty
              ? _list()
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const EnrollInsert());
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
                          "TOTAL ENROLLMENTS",
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
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                  itemCount: enrollController.enrollList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Get.to(
                          () => EnrollDetail(
                            enroll: enrollController.enrollList[index],
                          ),
                        );
                      },
                      child: Container(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "O/S ${enrollController.enrollList[index].balance.toString()}\$",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: Color(0xff67727d)),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        enrollController
                                            .enrollList[index].studentId.name,
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
                              const SizedBox(height: 10),
                              const Divider(),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "# OF PAYMENTS ${enrollController.enrollList[index].payments.length}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: Color(0xff67727d)),
                                ),
                              ),
                            ],
                          ),
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
