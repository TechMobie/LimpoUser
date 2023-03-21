import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/data/controllers/global_controller.dart';
import 'package:linpo_user/app/data/models/profile/profile_model.dart';
import 'package:linpo_user/app/modules/authentication/auth_provider.dart';
import 'package:linpo_user/app/routes/app_pages.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/helper/utils/constants.dart';
import 'package:linpo_user/helper/utils/pref_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';

class SignUpController extends GetxController {
  final globalController = Get.find<GlobalController>();

  TextEditingController firstNameSignUpController = TextEditingController();
  FocusNode firstNameSignUpFocusNode = FocusNode();

  TextEditingController lastNameSignUpController = TextEditingController();
  FocusNode lastNameSignUpFocusNode = FocusNode();

  TextEditingController passwordSignUpController = TextEditingController();
  FocusNode passwordSignUpFocusNode = FocusNode();

  TextEditingController emailSignUpController = TextEditingController();
  FocusNode emailSignUpFocusNode = FocusNode();
  TextEditingController confirmEmailSignUpController = TextEditingController();
  FocusNode confirmEmailSignUpFocusNode = FocusNode();

  TextEditingController repeatPasswordSignUpController =
      TextEditingController();
  FocusNode repeatPasswordSignUpFocusNode = FocusNode();

  TextEditingController phoneNumberSignUpController = TextEditingController();
  FocusNode phoneNumberSignUpFocusNode = FocusNode();
  DateTime selectedDate = DateTime.now();

  TextEditingController dobSignUpController = TextEditingController();
  FocusNode dobSignUpFocusNode = FocusNode();

  TextEditingController rutSignUpController = TextEditingController();
  FocusNode rutFocusNode = FocusNode();

  final authProvider = Get.put(AuthProvider());

  RxBool isSignUpEmailValid = true.obs;
  RxBool isConfirmSignUpEmailValid = true.obs;
  RxBool isSignUpPasswordValid = true.obs;
  RxBool isSignUpFirstNameValid = true.obs;
  RxBool isSignUpLastNameValid = true.obs;
  RxBool isSignUpRepeatPasswordValid = true.obs;
  RxBool isSignUpPhoneNumberValid = true.obs;
  // RxBool isSignUpDobValid = true.obs;
  RxBool isSignUpRutValid = true.obs;

  RxBool isSignUpEmailButtonValid = false.obs;
  RxBool isConfirmSignUpEmailButtonValid = false.obs;
  RxBool isSignUpPasswordButtonValid = false.obs;
  RxBool isSignUpFirstNameButtonValid = false.obs;
  RxBool isSignUpLastNameButtonValid = false.obs;
  RxBool isSignUpRepeatPasswordButtonValid = false.obs;
  RxBool isSignUpPhoneNumberButtonValid = false.obs;
  RxBool isSignUpDobButtonValid = false.obs;
  RxBool isSignUpRutButtonValid = false.obs;

  RxBool isForgotEmailValid = true.obs;
  RxBool isForgotEmailButtonValid = false.obs;

  RxBool isReceiveCheckBox = false.obs;
  RxBool isConditionCheckBox = false.obs;

  Future<void> signUpApiCall() async {
    CustomDialogs.getInstance.showProgressDialog();

    Map<String, dynamic> reqData = {
      "first_name": firstNameSignUpController.text.trimRight(),
      "last_name": lastNameSignUpController.text.trimRight(),
      "email": emailSignUpController.text.trimRight(),
      "password": passwordSignUpController.text.trimRight(),
      "rut": !isNullEmptyOrFalse(rutSignUpController.text)
          ? rutSignUpController.text.trimRight()
          : "",
      "mobile_country_code": "+56",
      if (!isNullEmptyOrFalse(phoneNumberSignUpController.text))
        "mobile_number": phoneNumberSignUpController.text.trimRight(),
      "date_of_birth": !isNullEmptyOrFalse(dobSignUpController.text)
          ? dobSignUpController.text.trimRight()
          : "",
      "email_and_promotion": isReceiveCheckBox.value ? 1 : 0,
      "terms_and_condition": isConditionCheckBox.value ? 1 : 0,
      "device_token": fcmToken,
      "device_os": Platform.operatingSystem,
      "device_os_version": (Platform.isAndroid)
          ? globalController.androidInfo?.version.release ?? ""
          : globalController.iosInfo?.systemVersion ?? "",
      "device_model": (Platform.isAndroid)
          ? globalController.androidInfo?.model ?? ""
          : globalController.iosInfo?.model ?? ""
    };
    if (kDebugMode) {
      print(reqData);
    }
    final response = await authProvider.signUpUser(reqData);
    if (kDebugMode) {
      print(response);
    }
    CustomDialogs.getInstance.hideProgressDialog();

    if (response['success'] == false) {
      showToast(
        msg: response['message'].toString(),
        color: ColorSchema.redColor.withOpacity(0.3),
      );
    } else {
      if (kDebugMode) {
        print("hello $response");
      }
      globalController.profileModel =
          ProfileModel.fromJson(response);
     
      PrefUtils.getInstance.writeData(
        PrefUtils.getInstance.accessToken,
        response['data']['user_session_token'],
      );
      PrefUtils.getInstance.writeData(
        PrefUtils.getInstance.profile,
        response,
      );
      
      Get.toNamed(Routes.otpScreen);
    }
  }
}
