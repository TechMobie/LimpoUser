import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/modules/plus/payment/payment_controller.dart';
import 'package:linpo_user/components/common_class.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class WebViewScreen extends StatelessWidget {
  WebViewScreen({Key? key}) : super(key: key);
  late WebViewController webViewController;
  final paymentController = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            WebView(
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (controller) {
                  webViewController = controller;
                  paymentController.isShowLoadForWeb.value = true;

                  String url = paymentController.webViewUrl + "?" + "TBK_TOKEN=${paymentController.tbkToken}";
                  final WebViewRequest request = WebViewRequest(
                    uri: Uri.parse(url),
                    method: WebViewRequestMethod.get,
                  );

                  webViewController.loadRequest(request);


                  // webViewController.loadRequest(WebViewRequest(
                  //     uri: Uri.parse(paymentController.webViewUrl),
                  //     body: Uint8List.fromList(utf8
                  //         .encode("TBK_TOKEN=${paymentController.tbk_token}")),
                  //     method: WebViewRequestMethod.post,
                  //     headers:{'Content-Type':'application/x-www-form-urlencoded'}));

                },
                onPageStarted: (String url) {
                  if (kDebugMode) {
                    print('Page started loading: $url');
                  }
                  paymentController.isShowLoadForWeb.value = true;

                  if (url.contains("https://localhost:8080/webpay/return")) {
                    Get.back();
                    paymentController.confirmEnrollmentApiCall();
                  }
                },
                onPageFinished: (String url) {
                  if (kDebugMode) {
                    print('Page finished loading: $url');
                  }
                  paymentController.isShowLoadForWeb.value = false;
                },
                navigationDelegate: (val) {
                  if (kDebugMode) {
                    print(val.url);
                  }
                  return NavigationDecision.navigate;
                },
                gestureNavigationEnabled: true,
                initialUrl: ""),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getSize(15.0)),
              child: CommonHeader(
                title: "",
              ),
            ),
            Obx(
              () => paymentController.isShowLoadForWeb.value
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: Colors.blue,
                    ))
                  : Stack(),
            )
          ],
        ),
      ),
    );
  }
}
