import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/modules/address/service_area_check_controller.dart';

import 'package:linpo_user/helper/utils/common_functions.dart';

class NoServiceController extends GetxController {
  final ServiceAreaCheckController serviceAreaCheckController = Get.find<ServiceAreaCheckController>();

  TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();

  RxBool isEmailValid = true.obs;
  RxBool isEmailButtonValid = false.obs;
  Future<void> coverageRequestApiCall({bool isFromAddAddress = true}) async {
    CustomDialogs.getInstance.showProgressDialog();

    Map<String, dynamic> reqData = {
      "latitude": serviceAreaCheckController.lat,
      "longitude": serviceAreaCheckController.long,
      "address": serviceAreaCheckController.directionController.text,    
      "email": emailController.text,
    };
    final response = await ApiCall().coveragerequest(reqData);
    print("============>$response");
    if (kDebugMode) {
      print(reqData);
    }

    CustomDialogs.getInstance.hideProgressDialog();
    Get.back();
    showToast(
      msg: response["message"].toString(),
    );
  }

  showToast({String? msg = "", Color? color}) {
    return Get.snackbar(
      "Limpo",
      msg!,
      backgroundColor: Colors.green[100],
      snackPosition: SnackPosition.TOP,
    );
  }
}
