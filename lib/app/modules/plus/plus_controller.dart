import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linpo_user/app/data/controllers/global_controller.dart';
import 'package:linpo_user/app/data/models/profile/profile_model.dart';
import 'package:linpo_user/app/modules/plus/plus_provider.dart';
import 'package:linpo_user/components/common_class.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/helper/utils/images.dart';
import 'package:linpo_user/helper/utils/pref_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PlusController extends GetxController {
//CONTACT US
  TextEditingController addCommentsController = TextEditingController();
  FocusNode addCommentsFocusNode = FocusNode();
  RxBool isCommentValid = true.obs;
  RxBool isCommentButtonValid = false.obs;
  RxBool isCategoryValid = true.obs;
  RxString? dropDownValue = "".obs;

  final plusProvider = Get.put(PlusProvider());

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  PackageInfo? packageInfo;
  IosDeviceInfo? iosInfo;
  AndroidDeviceInfo? androidInfo;
  final GlobalController globalController = Get.find();
  getAppVersion() async {
    packageInfo = await PackageInfo.fromPlatform();
    if (kDebugMode) {
      print(packageInfo!.version);
    }
  }

  //this is for you can get any devices identifier like  a which is a device model,os etc.
  getDeviceIdentifier() async {
    if (Platform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
      if (kDebugMode) {
        print(androidInfo!.model);
      }
    } else if (Platform.isIOS) {
      iosInfo = await deviceInfo.iosInfo;
      if (kDebugMode) {
        print(iosInfo!.systemVersion);
      }
      if (kDebugMode) {
        print(iosInfo!.model);
      }
    }
  }

  Future<void> logoutApiCall() async {
    Map<String, dynamic> reqData = {};
    final response = await plusProvider.logoutUser(reqData);
    if (kDebugMode) {
      print(response);
    }

    if (response['success'] == true) {
      await PrefUtils.getInstance.clearLocalStorage();
      globalController.profileModel = ProfileModel();
    } else {
      showToast(
        msg: response['error'].toString(),
        color: ColorSchema.redColor.withOpacity(0.3),
      );
    }
  }

  Future<void> deleteAccountApiCall() async {
    Map<String, dynamic> reqData = {};
    final response = await plusProvider.deleteAccount(reqData);
    if (kDebugMode) {
      print(response);
    }

    if (response['success'] == true) {
      PrefUtils.getInstance.clearLocalStorage();
      showToast(
        msg: response['message'].toString(),
        color: ColorSchema.greenColor.withOpacity(0.3),
      );
    } else {
      showToast(
        msg: response['error'].toString(),
        color: ColorSchema.redColor.withOpacity(0.3),
      );
    }
  }

  Future<void> contactUsApiCall(BuildContext context) async {
    CustomDialogs.getInstance.showProgressDialog();

    Map<String, dynamic> reqData = {
      "category": dropDownValue!.value,
      "comment": addCommentsController.text.trimRight()
    };
    if (kDebugMode) {
      print(reqData);
    }
    final response = await plusProvider.contactUs(reqData);

    if (response['success'] == false) {
      CustomDialogs.getInstance.hideProgressDialog();
      showToast(
        msg: response['message'].toString(),
        color: ColorSchema.redColor.withOpacity(0.3),
      );
    } else {
      CustomDialogs.getInstance.hideProgressDialog();
      showDialog(
          context: context,
          builder: (_) => Alertdialog(
              isFullButton: true,
              titleWidget: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    ImageConstants.successPlan,
                    height: 200,
                  ),
                  Text(
                    AppLocalizations.of(context)!.messageSent,
                    style: const TextStyle().normal16,
                  )
                ],
              ),
              contentText: AppLocalizations.of(context)!.weWillContact,
              actionWidget: Text(
                AppLocalizations.of(context)!.returnCaps,
                style: const TextStyle()
                    .size(16)
                    .bold
                    .textColor(ColorSchema.whiteColor),
              ),
              onTap: () {
                Get.back();
                Get.back();
              }));
    }
    if (kDebugMode) {
      print(response);
    }
  }

  @override
  void onInit() async {
    super.onInit();

    if (PrefUtils.getInstance.isUserLogin()) {
      await getDeviceIdentifier();
      await getAppVersion();
    }
  }
}
