import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_project/Models/payment.dart';
import 'package:school_project/Views/Payments/payment_edit.dart';
import 'package:school_project/properties.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../Controllers/payment_controller.dart';

final isLoading = ValueNotifier<bool>(true);

class PaymentDetail extends StatefulWidget {
  const PaymentDetail({Key? key, required this.pid, required this.payment})
      : super(key: key);

  final int pid;
  final Payment payment;

  @override
  State<PaymentDetail> createState() => _PaymentDetailState();
}

class _PaymentDetailState extends State<PaymentDetail> {
  int pid = 0;
  String get _url {
    return "${Properties.BASE_URL}/payment/invoice/${pid.toString()}";
  }

  var paymentController = Get.put(PaymentController());

  @override
  void initState() {
    super.initState();
    pid = widget.pid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Detail'),
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: isLoading,
        builder: (context, value, child) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
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
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        const Icon(Icons.account_circle,
                                            color: Color(0xff67727d)),
                                        const SizedBox(width: 5),
                                        Text(
                                          widget.payment.createdBy.username,
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
                                      "${widget.payment.amount.toString()}\$",
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
                                      Icons.attach_money,
                                      color: Colors.white,
                                    ),
                                  ),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.payment.dateCreated.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: Color(0xff67727d)),
                              ),
                            ),
                            const SizedBox(height: 35),
                            ButtonBar(
                              buttonPadding:
                                  const EdgeInsetsDirectional.only(start: 0),
                              alignment: MainAxisAlignment.start,
                              children: [
                                ElevatedButton(
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
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
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.blue),
                                  ),
                                  onPressed: () {
                                    Get.to(
                                      () => PaymentEdit(
                                        pid: widget.payment.id,
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 15),
                                ElevatedButton(
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
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
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.redAccent),
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
                    const SizedBox(height: 35),
                    Expanded(child: WebViewWidget(url: _url))
                  ],
                ),
              ),
              (value == true
                  ? const Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Container()),
            ],
          );
        },
      ),
    );
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
                paymentController.deletePaymentById(widget.payment.id);
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

class WebViewWidget extends StatefulWidget {
  const WebViewWidget({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  State<WebViewWidget> createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  late WebView _webView;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    _webView = WebView(
      initialUrl: widget.url,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        _controller.complete(webViewController);
      },
      onProgress: (int progress) {},
      onPageStarted: (String url) {
        isLoading.value = true;
      },
      onPageFinished: (String url) async {
        final controller = await _controller.future;
        controller
            .runJavascriptReturningResult(
                'document.body.style.backgroundColor = "#f8f9fc";'
                'document.getElementsByClassName("navbar")[0].style.display = "none";'
                'document.querySelector(".container-fluid a.btn-danger").style.display = "none";'
                'document.querySelector(".container-fluid a.btn-primary").style.display = "none";'
                'document.getElementById("accordionSidebar").style.display = "none";'
                'document.getElementById("sidebarToggleTop").style.display = "none";'
                'document.querySelector(".container-fluid").style.padding = 0;'
                'document.querySelector("#invoice").style.padding = 0;'
                'document.querySelector(".sticky-footer").style.display = "none";'
                'document.querySelector(".container-fluid > .d-sm-flex").style.display = "none"; ')
            .then(
          (value) async {
            await Future.delayed(const Duration(seconds: 1));
            isLoading.value = false;
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _webView;
  }
}
