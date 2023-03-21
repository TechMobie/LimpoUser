// ignore_for_file: avoid_print
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/data/models/generalModel/general_model.dart';
import 'package:linpo_user/app/data/models/profile/profile_model.dart';
import 'package:linpo_user/app/modules/MyWashingMachine/my_washing_machine_provider.dart';
import 'package:linpo_user/app/modules/plus/plus_provider.dart';
import 'package:linpo_user/app/routes/app_pages.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/helper/utils/constants.dart';
import 'package:linpo_user/helper/utils/pref_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:package_info_plus/package_info_plus.dart';

class GlobalController extends GetxController {
  final RxBool noNetwork = false.obs;
  String? hasINternet;
  ProfileModel profileModel = ProfileModel();
  final plusProvider = Get.put(PlusProvider());

  // ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  Future<void> initConnectivity() async {
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(
        'Couldn\'t check connectivity status===========$e',
      );
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    print("===================================" + result.name);
    hasINternet = result.name;
    if (hasINternet == "none") {
      Get.toNamed(Routes.noInternetScreen);
      // NoInternetConnectionScreen();
    }

    if (hasINternet == "wifi" || hasINternet == "mobile") {
      Get.back();
      // if (PrefUtils.getInstance.isUserLogin()) {
      //   Get.offAllNamed(Routes.bottomBarScreen);
      // } else {
      // Get.offAllNamed(Routes.addAddress);
      // }
    }

    // _connectionStatus = result;

    update();
  }

  MyWashingMachineProvider myWashingMachineProvider =
      MyWashingMachineProvider();
  GeneralModel generalModel = GeneralModel();
  int currentIndex = 0;

  Future getGeneralSettingApiCall() async {
    final response = await myWashingMachineProvider.generalSetting({});
    if (!isNullEmptyOrFalse(response)) {
      generalModel = GeneralModel.fromJson(response);
      print(
          "+++++++++++++++++++++++++++++${generalModel.data!.bannerImage!.length}");
      PrefUtils.getInstance.writeData(
        PrefUtils.getInstance.generalSetting,
        response,
      );
    }

    print(response);
    update();
  }

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  PackageInfo? packageInfo;
  IosDeviceInfo? iosInfo;
  AndroidDeviceInfo? androidInfo;
  getAppVersion() async {
    packageInfo = await PackageInfo.fromPlatform();
    if (kDebugMode) {
      print(packageInfo!.version);
    }
  }

  //this is for you can get any devices identifier like a which is a device model,os etc.
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

  Future<void> lastLoginApiCall() async {
    // profileModel =
    // ProfileModel.fromJson(PrefUtils.getInstance.readData(
    //   PrefUtils.getInstance.profile,
    // ));

    // var fcmToken;
    Map<String, dynamic> reqData = {
      "device_token": fcmToken,
      "device_os": Platform.operatingSystem,
      "device_os_version": (Platform.isAndroid)
          ? androidInfo?.version.release ?? ""
          : iosInfo?.systemVersion ?? "",
      "device_model":
          (Platform.isAndroid) ? androidInfo?.model ?? "" : iosInfo?.model ?? ""
    };
    final response = await plusProvider.lastLogin(reqData);

    if (response['success'] == false) {
      showToast(
        msg: response['message'].toString(),
        color: ColorSchema.redColor.withOpacity(0.3),
      );
    } else {
      profileModel = ProfileModel.fromJson(response);

      PrefUtils.getInstance.writeData(
        PrefUtils.getInstance.profile,
        response,
      );
    }

    if (kDebugMode) {
      print("last login: $response");
    }
    update();
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    if (PrefUtils.getInstance.isUserLogin()) {
      generalModel = GeneralModel.fromJson(PrefUtils.getInstance.readData(
        PrefUtils.getInstance.generalSetting,
      ));
      await getDeviceIdentifier();
      await getAppVersion();
      await lastLoginApiCall();

      if (kDebugMode) {
        print("fcmToken----" + fcmToken);
      }
    } //await initConnectivity();
    super.onInit();
  }
}
