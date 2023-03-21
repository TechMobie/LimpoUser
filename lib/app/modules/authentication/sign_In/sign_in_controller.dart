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

class SignInController extends GetxController {
  final GlobalController globalController = Get.find<GlobalController>();
  TextEditingController emailSignInController = TextEditingController();
  FocusNode emailSignInFocusNode = FocusNode();

  TextEditingController passwordSignInController = TextEditingController();
  FocusNode passwordSignInFocusNode = FocusNode();
  RxBool isSignInEmailValid = true.obs;
  RxBool isSignInPasswordValid = true.obs;
  RxBool isSignInEmailButtonValid = false.obs;
  RxBool isSignInPasswordButtonValid = false.obs;

  RxBool isSignUpEmailValid = true.obs;
  RxBool isConfirmSignUpEmailValid = true.obs;

  final authProvider = Get.put(AuthProvider());

  Future<void> logInApiCall() async {
    CustomDialogs.getInstance.showProgressDialog();

    Map<String, dynamic> reqData = {
      "email": emailSignInController.text.trimRight(),
      "password": passwordSignInController.text.trimRight(),
      "device_token": fcmToken,
      "device_os": Platform.operatingSystem,
      "device_os_version": (Platform.isAndroid)
          ? globalController.androidInfo?.version.release ?? ""
          : globalController.iosInfo?.systemVersion ?? "",
      "device_model": (Platform.isAndroid)
          ? globalController.androidInfo?.model ?? ""
          : globalController.iosInfo?.model ?? ""
    };

    final response = await authProvider.loginUser(reqData);

    CustomDialogs.getInstance.hideProgressDialog();
    if (kDebugMode) {
      print(response);
    }

    try {
      if (response['success'] == false) {
        showToast(
          msg: response['message'].toString(),
          color: ColorSchema.redColor.withOpacity(0.3),
        );
      } else if (response['data']["email_verified_at"] == null) {
        PrefUtils.getInstance.writeData(
          PrefUtils.getInstance.accessToken,
          response['data']['user_session_token'],
        );
        globalController.profileModel = ProfileModel.fromJson(response);
        PrefUtils.getInstance.writeData(
          PrefUtils.getInstance.profile,
          response,
        );

        Get.toNamed(Routes.otpScreen);
      } else {
        PrefUtils.getInstance.writeData(
          PrefUtils.getInstance.accessToken,
          response['data']['user_session_token'],
        );
        globalController.profileModel.data?.firstName =
            response['data']['first_name'];
        globalController.profileModel = ProfileModel.fromJson(response);

        PrefUtils.getInstance.writeData(
          PrefUtils.getInstance.profile,
          response,
        );
        Get.offAllNamed(Routes.bottomBarScreen);
      }
    } catch (e) {
      print(e);
    }
  }
}
