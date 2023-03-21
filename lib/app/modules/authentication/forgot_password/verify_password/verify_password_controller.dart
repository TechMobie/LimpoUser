import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/modules/authentication/auth_provider.dart';
import 'package:linpo_user/app/modules/authentication/forgot_password/forgot_password_controller.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:otp_text_field/otp_field.dart';

class VerifyPasswordController extends GetxController {
  OtpFieldController otpController = OtpFieldController();
  String otp = '';

  TextEditingController newPasswordController = TextEditingController();
  FocusNode newPasswordFocusNode = FocusNode();

  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode confirmPasswordFocusNode = FocusNode();

  RxBool isShowNewPassword = false.obs;
  RxBool isShowConfirmPassword = false.obs;

  RxBool isNewPasswordValid = true.obs;
  RxBool isConfirmPasswordValid = true.obs;

  final authProvider = Get.put(AuthProvider());
  final forgotPasswordController = Get.find<ForgotPasswordController>();

  Future<void> resetPasswordApiCall() async {
    CustomDialogs.getInstance.showProgressDialog();

    Map<String, dynamic> reqData = {
      "email": forgotPasswordController.emailForgotController.text.trimRight(),
      "otp": otp,
      "password": confirmPasswordController.text,
    };

    final response = await authProvider.resetPasswordUser(reqData);

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
      Get.back();
      Get.back();
      showToast(
        msg: response['message'].toString(),
        color: ColorSchema.greenColor.withOpacity(0.3),
      );
    }
    otp = "";
    otpController.clear();
    confirmPasswordController.clear();
    newPasswordController.clear();
    isNewPasswordValid.value = true;
    isConfirmPasswordValid.value = true;
    update();
  }
}
