import 'package:get/get.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:linpo_user/app/data/models/profile/profile_model.dart';
import 'package:linpo_user/app/modules/plus/plus_provider.dart';
import 'package:linpo_user/app/routes/app_pages.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/helper/utils/pref_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:package_info_plus/package_info_plus.dart';

class OTPScreenController extends GetxController {
  OtpFieldController otpController = OtpFieldController();
  String otp = '';
  ProfileModel profileModel = ProfileModel();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  PackageInfo? packageInfo;
  IosDeviceInfo? iosInfo;
  AndroidDeviceInfo? androidInfo;
  final plusProvider = Get.put(PlusProvider());

  Future<void> verifyOtpApiCall() async {
    CustomDialogs.getInstance.showProgressDialog();

    Map<String, dynamic> reqData = {"otp": otp};
    final response = await plusProvider.verifyOtpUser(reqData);

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
      ProfileModel profileModel =
          ProfileModel.fromJson(PrefUtils.getInstance.readData(
        PrefUtils.getInstance.profile,
      ));

      profileModel.data?.emailVerifiedAt = "dipak";

      PrefUtils.getInstance.writeData(
        PrefUtils.getInstance.profile,
        profileModel.toJson(),
      );

      Get.offAllNamed(Routes.bottomBarScreen);

      CustomDialogs.getInstance.hideProgressDialog();
      showToast(
        msg: response['message'].toString(),
        color: ColorSchema.greenColor.withOpacity(0.3),
      );
    }
  }

  Future<void> resendOtpApiCall() async {
    CustomDialogs.getInstance.showProgressDialog();

    Map<String, dynamic> reqData = {};
    final response = await plusProvider.resendOtpUser(reqData);

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
      showToast(
        msg: response['message'].toString(),
        color: ColorSchema.greenColor.withOpacity(0.3),
      );
    }
  }

  
}
