import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/modules/plus/payment/payment_controller.dart';
import 'package:linpo_user/app/modules/services/services_controller.dart';
import 'package:linpo_user/components/common_class.dart';
import 'package:linpo_user/components/stepper/stepper.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/helper/utils/date_utils.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:linpo_user/app/modules/MyWashingMachine/my_washing_machine_controller.dart';
import 'package:linpo_user/app/modules/MyWashingMachine/retreat_controller.dart';
import 'package:linpo_user/app/modules/plus/my_address/my_address_controller.dart';

// ignore: must_be_immutable
class WebPayMentScreen extends StatefulWidget {
  WebPayMentScreen({Key? key}) : super(key: key);

  @override
  State<WebPayMentScreen> createState() => _WebPayMentScreenState();
}

class _WebPayMentScreenState extends State<WebPayMentScreen> {
  late WebViewController webViewController;

  final paymentController = Get.find<PaymentController>();

  final myWashingMachineController = Get.find<MyWashingMachineController>();

  final retreatController = Get.find<RetreatController>();

  final myAddressController = Get.find<MyAddressController>();

  final servicesController = Get.find<ServicesController>();

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

                  String url = paymentController
                          .createwebViewUrlForWebPaymentScreen +
                      "?" +
                      "TBK_TOKEN=${paymentController.createTokenForWebPaymentScreen}";
                  final WebViewRequest request = WebViewRequest(
                    uri: Uri.parse(url),
                    method: WebViewRequestMethod.get,
                  );

                  webViewController.loadRequest(request);
                },
                onPageStarted: (String url) {
                  if (kDebugMode) {
                    print('Page started loading: $url');
                  }
                  paymentController.isShowLoadForWeb.value = true;

                  if (url.contains("https://localhost:8080/webpay/return")) {
                    Get.back();
                    paymentController
                        .confirmTransactionApiCall(
                            token: paymentController
                                .createTokenForWebPaymentScreen,
                            userAddressid: myAddressController.defaultAddressModel.id
                                .toString(),
                            pickUpDate: DateUtilities.convertDateTimeToString(
                                date:
                                    retreatController.pickUpSelectedDate.value,
                                dateFormatter: DateUtilities.yyyy_mm_dd),
                            pickUpTime:
                                retreatController.selectTimeForPickUp.value ==
                                        "09:00-13:00"
                                    ? "09:00-13:00"
                                    : "14:00-18:00",
                            deliveryDate: DateUtilities.convertDateTimeToString(
                                date: retreatController
                                    .deliverySelectedDate.value,
                                dateFormatter: DateUtilities.yyyy_mm_dd),
                            deliveryTime:
                                retreatController.selectTimeForDelivery.value ==
                                        "09:00-13:00"
                                    ? "09:00-13:00"
                                    : "14:00-18:00",
                            whoWillReceive: myWashingMachineController
                                    .checkValue1.value
                                ? "I'll receive"
                                : myWashingMachineController.checkValue2.value
                                    ? "drop off at concierge"
                                    : myWashingMachineController
                                        .personReceiveController.text
                                        .trimRight(),
                            comments: myWashingMachineController
                                .addCommentsController.text
                                .trimRight())
                        .then((value) {
                      if ((value['success'] ?? false) == false) {
                        showToast(
                          msg: value['message'] ?? "",
                          color: ColorSchema.redColor.withOpacity(0.3),
                        );
                      } else {
                        // currentStep = 3;
                        currentStep++;
                        controller!.jumpToPage(currentStep);

                        setState(() {});

                        servicesController.getProductApiCall();
                      }
                    });
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
