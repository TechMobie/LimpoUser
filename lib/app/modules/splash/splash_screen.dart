import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/data/controllers/global_controller.dart';
import 'package:linpo_user/app/data/models/profile/profile_model.dart';
import 'package:linpo_user/app/routes/app_pages.dart';
import 'package:linpo_user/helper/utils/constants.dart';
import 'package:linpo_user/helper/utils/images.dart';
import 'package:linpo_user/helper/utils/pref_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalController globalController =
      Get.find<GlobalController>();
  @override
  void initState() {
    globalController.initConnectivity();
    if (kDebugMode) {
      print("device token: ${PrefUtils.getInstance.readData(
        PrefUtils.getInstance.accessToken,
      )}");
    }
    if (kDebugMode) {
      print(PrefUtils.getInstance.readData(
        PrefUtils.getInstance.profile,
      ));
    }
    goToNextSplash();
    super.initState();
  }

  goToNextSplash() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    await FirebaseMessaging.instance.getToken().then((value) {
      fcmToken = value??"";
      if (kDebugMode) {
        print("Firebase_token ---> " + fcmToken);
      }
    });
    await globalController.getGeneralSettingApiCall();

    Future.delayed(const Duration(milliseconds: 2500), () async {
      // FirebaseCrashlytics.instance.crash();

      if (globalController.hasINternet == "wifi" ||
          globalController.hasINternet == "mobile") {
        if (await PrefUtils.getInstance.isUserLogin()) {
          ProfileModel profileModel =
              ProfileModel.fromJson(PrefUtils.getInstance.readData(
            PrefUtils.getInstance.profile,

          ));

          globalController.profileModel = profileModel;
          if (profileModel.data?.emailVerifiedAt == null) {
            Get.offAllNamed(Routes.otpScreen);
          } else {
            Get.offAllNamed(Routes.bottomBarScreen);
          }
          // PrefUtils.getInstance.initializeUser();

        } else {
          Get.offAllNamed(Routes.bottomBarScreen);
        }
      }
    });

    myLocale = Localizations.localeOf(Get.context!);
    if (kDebugMode) {
      print(myLocale);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSchema.whiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 100, right: 100),
              child: SvgPicture.asset(
                ImageConstants.appIcon,
                color: ColorSchema.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
