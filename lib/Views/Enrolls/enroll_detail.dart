import 'package:flutter/material.dart';
import 'package:school_project/Models/enroll.dart';

class EnrollDetail extends StatefulWidget {
  const EnrollDetail({Key? key, required this.enroll}) : super(key: key);

  final Enroll enroll;

  @override
  State<EnrollDetail> createState() => _EnrollDetailState();
}

class _EnrollDetailState extends State<EnrollDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.enroll.studentId.name} Enrollment"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: (widget.enroll.payments.isNotEmpty
              ? ListView.builder(
                  itemCount: widget.enroll.payments.length,
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
                                    Row(
                                      children: [
                                        const Icon(Icons.account_circle,
                                            color: Color(0xff67727d)),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          widget.enroll.payments[index]
                                              .createdBy.username
                                              .toUpperCase(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                              color: Color(0xff67727d)),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "${widget.enroll.payments[index].dateCreated}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          color: Color(0xff67727d)),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "${widget.enroll.payments[index].amount}\$",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 35,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "${widget.enroll.courseId.name} ${widget.enroll.courseId.level}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          color: Color(0xff67727d)),
                                    ),
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
                            )
                          ],
                        ),
                      ),
                    );
                  })
              : const Center(
                  child: Icon(
                  Icons.sentiment_very_dissatisfied,
                  color: Color(0xff67727d),
                  size: 45,
                ))),
        ),
      ),
    );
  }
}
