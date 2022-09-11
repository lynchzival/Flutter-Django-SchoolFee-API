import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_project/Models/payment.dart';
import 'package:school_project/properties.dart';
import 'package:webview_flutter/webview_flutter.dart';

final isLoading = ValueNotifier<bool>(true);

class PaymentEdit extends StatefulWidget {
  const PaymentEdit({Key? key, required this.pid}) : super(key: key);

  final int pid;

  @override
  State<PaymentEdit> createState() => _PaymentEditState();
}

class _PaymentEditState extends State<PaymentEdit> {
  int pid = 0;
  String get _url {
    return "${Properties.BASE_URL}/payment/edit/${pid.toString()}/";
  }

  @override
  void initState() {
    super.initState();
    pid = widget.pid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Edit'),
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: isLoading,
        builder: (context, value, child) {
          return Stack(
            children: [
              WebViewWidget(url: _url),
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
                  'document.body.style.paddingTop = "40px";'
                  'document.getElementsByClassName("navbar")[0].style.display = "none";'
                  'document.querySelector(".container-fluid a.btn-danger").style.display = "none";'
                  'document.getElementById("accordionSidebar").style.display = "none";'
                  'document.getElementById("sidebarToggleTop").style.display = "none";'
                  'document.querySelector(".sticky-footer").style.display = "none";'
                  'const alerts = document.querySelectorAll(".alert-success"); for (const alert of alerts) { alert.style.display = "none"; };')
              .then(
            (value) async {
              await Future.delayed(const Duration(seconds: 1));
              isLoading.value = false;
            },
          );
        },
        navigationDelegate: (request) {
          if (request.url.contains("${Properties.BASE_URL}/payment/")) {
            Get.back();
            Get.back();
            Get.showSnackbar(
              const GetSnackBar(
                title: "Success",
                message: "Payment Updated",
                isDismissible: true,
                backgroundColor: Colors.blue,
                duration: Duration(seconds: 2),
              ),
            );
            return NavigationDecision.prevent;
          } else {
            return NavigationDecision.navigate;
          }
        });
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
