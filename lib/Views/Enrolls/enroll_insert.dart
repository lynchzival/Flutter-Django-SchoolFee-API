import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_project/properties.dart';
import 'package:webview_flutter/webview_flutter.dart';

final isLoading = ValueNotifier<bool>(true);

class EnrollInsert extends StatefulWidget {
  const EnrollInsert({Key? key}) : super(key: key);

  @override
  State<EnrollInsert> createState() => _EnrollInsertState();
}

class _EnrollInsertState extends State<EnrollInsert> {
  static String get _url {
    return "${Properties.BASE_URL}/enroll/create/";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enroll Insert'),
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
        if (request.url.contains("${Properties.BASE_URL}/enroll/")) {
          Navigator.pop(context);
          Get.showSnackbar(
            const GetSnackBar(
              title: "Success",
              message: "Enrollment Added",
              isDismissible: true,
              backgroundColor: Colors.blue,
              duration: Duration(seconds: 2),
            ),
          );
          return NavigationDecision.prevent;
        } else {
          return NavigationDecision.navigate;
        }
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
