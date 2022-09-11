import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_project/Controllers/payment_controller.dart';
import 'package:school_project/Views/Payments/payment_detail.dart';
import 'package:school_project/Views/Payments/payment_insert.dart';
import 'package:school_project/Widgets/sidebar.dart';

class PaymentList extends StatefulWidget {
  const PaymentList({Key? key}) : super(key: key);

  @override
  State<PaymentList> createState() => _PaymentListState();
}

class _PaymentListState extends State<PaymentList> {
  var paymentController = Get.put(PaymentController());

  Future _refresh() async {
    await paymentController.onInit();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        title: const Text('Payment List'),
      ),
      body: FutureBuilder(
        future: _refresh(),
        builder: (context, snapshot) {
          return paymentController.paymentList.isNotEmpty
              ? _list()
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const PaymentInsert());
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
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                  itemCount: paymentController.paymentList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Get.to(
                          () => PaymentDetail(
                            pid: paymentController.paymentList[index].id,
                            payment: paymentController.paymentList[index],
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
                                        paymentController
                                            .paymentList[index].dateCreated
                                            .toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: Color(0xff67727d)),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "${paymentController.paymentList[index].amount.toString()}\$",
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
                                        Icons.receipt,
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
                                child: Row(
                                  children: [
                                    const Icon(Icons.account_circle,
                                        color: Color(0xff67727d)),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      paymentController
                                          .paymentList[index].createdBy.username
                                          .toUpperCase(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          color: Color(0xff67727d)),
                                    )
                                  ],
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
