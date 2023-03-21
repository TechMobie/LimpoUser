import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/data/controllers/global_controller.dart';
import 'package:linpo_user/app/data/models/profile/profile_model.dart';
import 'package:linpo_user/app/modules/MyWashingMachine/my_washing_machine_controller.dart';
import 'package:linpo_user/app/modules/MyWashingMachine/my_washing_machine_screen.dart';
import 'package:linpo_user/app/modules/bottomBar/bottom_bar_controller.dart';
import 'package:linpo_user/app/modules/plus/my_address/my_address_controller.dart';
import 'package:linpo_user/app/modules/plus/payment/payment_controller.dart';
import 'package:linpo_user/app/modules/plus/plus_provider.dart';
import 'package:linpo_user/app/modules/plus/plus_screen.dart';
import 'package:linpo_user/app/modules/services/services_controller.dart';
import 'package:linpo_user/app/modules/services/services_screen.dart';
import 'package:linpo_user/app/modules/start/start_screen.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/helper/utils/constants.dart';
import 'package:linpo_user/helper/utils/images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linpo_user/helper/utils/pref_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:linpo_user/schemata/text_style.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  // final plusController = Get.put<PlusController>(PlusController());
  final bottomBarScreenController =
      Get.put<BottomBarController>(BottomBarController());
  final servicesController = Get.put<ServicesController>(ServicesController());
  final myAddressController =
      Get.put<MyAddressController>(MyAddressController());

  final myWashingMachineController =
      Get.put<MyWashingMachineController>(MyWashingMachineController());
  final paymentController = Get.put<PaymentController>(PaymentController());
  final GlobalController globalController = Get.find<GlobalController>();
  // final authenticationController =
  //     Get.put<AuthenticationController>(AuthenticationController());
  var pageController = PageController(initialPage: 0);

  List<Widget> pageList = [
    StartScreen(),
    ServiceScreen(),
    MyWashingMachineScreen(),
    const PlusScreen()
  ];

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          ImageConstants.start,
        ),
      ),
      activeIcon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          ImageConstants.start,
          color: ColorSchema.primaryColor,
        ),
      ),
      label: AppLocalizations.of(Get.context!)!.start,
    ),
    BottomNavigationBarItem(
      icon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          ImageConstants.service,
        ),
      ),
      activeIcon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          ImageConstants.service,
          color: ColorSchema.primaryColor,
        ),
      ),
      label: AppLocalizations.of(Get.context!)!.services,
    ),
    BottomNavigationBarItem(
      icon: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          SizedBox(
            height: 25,
            width: 25,
            child: SvgPicture.asset(
              ImageConstants.laundarymachine,
            ),
          ),
          Obx(() => (totalQuentity.value != 0)
              ? Positioned(
                  right: 0,
                  child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: ColorSchema.lightBlueColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: Text(
                        totalQuentity.value.toStringAsFixed(0).toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      )),
                )
              : const SizedBox())
        ],
      ),
      activeIcon: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          SizedBox(
            height: 25,
            width: 25,
            child: SvgPicture.asset(
              ImageConstants.laundarymachine,
              color: ColorSchema.primaryColor,
            ),
          ),
          Obx(() => (totalQuentity.value != 0)
              ? Positioned(
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: ColorSchema.lightBlueColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: Text(
                      totalQuentity.value.toStringAsFixed(0).toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : const SizedBox())
        ],
      ),
      label: AppLocalizations.of(Get.context!)!.myWashingMachine,
    ),
    BottomNavigationBarItem(
      icon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          ImageConstants.plus,
        ),
      ),
      activeIcon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          ImageConstants.plus,
          color: ColorSchema.primaryColor,
        ),
      ),
      label: AppLocalizations.of(Get.context!)!.plus,
    ),
  ];

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

  final plusProvider = Get.put(PlusProvider());
  // ProfileModel profileModel = ProfileModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: bottomBarScreenController.currentIndex.value,
            children: pageList,
          )),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: bottomBarScreenController.currentIndex.value,
          onTap: (val) {
            if (PrefUtils.getInstance.isUserLogin()) {
              bottomBarScreenController.currentIndex.value = val;
              if (val == 2) {
                myWashingMachineController.getCartApiCall();
                globalController.profileModel =
                    ProfileModel.fromJson(PrefUtils.getInstance.readData(
                  PrefUtils.getInstance.profile,
                ));
                // print(plusController.profileModel.data?.mobileNumber);
                print(globalController.profileModel.data?.mobileNumber);
              } else if (val == 1) {
                servicesController.getProductApiCall();
              }
              bottomBarScreenController.update();
            } else {
              if (val == 2 || val == 3) {
                commonGuestDialogue(context);
              } else {
                bottomBarScreenController.currentIndex.value = val;
              }
            }
          },
          type: BottomNavigationBarType.fixed,
          items: bottomItems,
          selectedLabelStyle:
              const TextStyle().normal12.textColor(ColorSchema.primaryColor),
          selectedFontSize: 12,
          selectedItemColor: ColorSchema.primaryColor,
          unselectedItemColor: disableColor(context),
          selectedIconTheme:
              IconThemeData(color: Theme.of(context).toggleableActiveColor),
          unselectedIconTheme: IconThemeData(color: disableColor(context)),
        ),
      ),
    );
  }

  Color disableColor(BuildContext context) => Theme.of(context).disabledColor;
}
