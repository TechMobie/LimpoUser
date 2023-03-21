import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/modules/authentication/auth_provider.dart';
import 'package:linpo_user/app/routes/app_pages.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/schemata/color_schema.dart';

class ForgotPasswordController extends GetxController {
  final authProvider = Get.put(AuthProvider());

  TextEditingController emailForgotController = TextEditingController();
  FocusNode emailForgotFocusNode = FocusNode();
  RxBool isForgotEmailValid = true.obs;
  RxBool isForgotEmailButtonValid = false.obs;

  Future<void> forgotPasswordApiCall() async {
    CustomDialogs.getInstance.showProgressDialog();

    Map<String, dynamic> reqData = {
      "email": emailForgotController.text.trimRight(),
    };
    final response = await authProvider.forgotPasswordUser(reqData);

    CustomDialogs.getInstance.hideProgressDialog();
    if (kDebugMode) {
      print(response);
    }
    if (response['success'] == false) {
      showToast(
        msg: response['message'].toString(),
        color: ColorSchema.redColor.withOpacity(0.3),
      );
    } else {
      // Get.back();
      Get.toNamed(Routes.verifyEmailScreen);
      // showGeneralDialog(
      //   context: Get.context!,
      //   barrierDismissible: false,
      //   pageBuilder: (_, __, ___) {
      //     return verifyPassword();
      //   },
      // );
      showToast(
        msg: response['message'].toString(),
        color: ColorSchema.greenColor.withOpacity(0.3),
      );
    }
  }
}
