import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/data/services/api_service/api_service.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/helper/utils/constants.dart';
import 'package:linpo_user/schemata/color_schema.dart';

class ChangePasswordController extends GetxController {
  TextEditingController oldPasswordController = TextEditingController();
  FocusNode oldPasswordFocusNode = FocusNode();

  TextEditingController newPasswordController = TextEditingController();
  FocusNode newPasswordFocusNode = FocusNode();

  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode confirmPasswordFocusNode = FocusNode();

  RxBool isOldPasswordValid = true.obs;
  RxBool isNewPasswordValid = true.obs;
  RxBool isConfirmPasswordValid = true.obs;
  RxBool isOldPasswordButtonValid = false.obs;
  RxBool isNewPasswordButtonValid = false.obs;
  RxBool isConfirmPasswordButtonValid = false.obs;
  RxBool isShowOldPassword = false.obs;
  RxBool isShowNewPassword = false.obs;
  RxBool isShowConfirmPassword = false.obs;

  Future<void> changePasswordApiCall() async {
    CustomDialogs.getInstance.showProgressDialog();

    Map<String, dynamic> reqData = {
      "old_password": oldPasswordController.text.trimRight(),
      "new_password": newPasswordController.text.trimRight()
    };
    final response = await ApiService.postRequest(
      ApiConstants.changePasswordUrl,
      body: reqData,
    );

    if (response['success'] == false) {
      CustomDialogs.getInstance.hideProgressDialog();
      showToast(
        msg: response['message'].toString(),
        color: ColorSchema.redColor.withOpacity(0.3),
      );
    } else {
      Get.back();
      CustomDialogs.getInstance.hideProgressDialog();

      showToast(
        msg: response['message'].toString(),
        color: ColorSchema.greenColor.withOpacity(0.3),
      );
    }
  }
}
