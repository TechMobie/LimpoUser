import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linpo_user/components/button/button.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/helper/utils/pref_utils.dart';
import 'package:linpo_user/app/modules/otp/otp_controller.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'package:otp_text_field/otp_text_field.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final otpScreenController =
      Get.put<OTPScreenController>(OTPScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: otpScreenController,
        builder: (controller) => SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getSize(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: getSize(70),
                  ),
                  Text(AppLocalizations.of(Get.context!)!.verificationCode,
                      style: const TextStyle().size(27).bold),
                  SizedBox(
                    height: getSize(30),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: getSize(0)),
                    child: Text(
                      AppLocalizations.of(Get.context!)!.enterTheCode,
                      style: const TextStyle().normal16,
                      //textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: getSize(40),
                  ),
                  OTPTextField(
                      controller: otpScreenController.otpController,
                      length: 4,
                      width: MediaQuery.of(Get.context!).size.width,
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldWidth: 55,
                      // fieldStyle: FieldStyle.box,
                      outlineBorderRadius: 15,
                      style: const TextStyle().medium16,
                      onChanged: (pin) {
                        print("Changed: " + pin);
                      },
                      onCompleted: (pin) {
                        otpScreenController.otp = pin;
                        otpScreenController.update();
                        print("Completed: " + pin);
                        PrefUtils.getInstance.writeData(
                          PrefUtils.getInstance.otpLoader,
                          pin,
                        );
                      }),
                  SizedBox(
                    height: getSize(40),
                  ),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          otpScreenController.resendOtpApiCall();
                          otpScreenController.update();
                        },
                        child: Text(
                          AppLocalizations.of(Get.context!)!.sendAgain,
                          style: TextStyle()
                              .medium16
                              .textColor(ColorSchema.greenColor),
                        )),
                  ),
                  SizedBox(
                    height: getSize(40),
                  ),
                  CommonAppButton(
                      text: AppLocalizations.of(Get.context!)!.verifyEmail,
                      onTap: () {
                        otpScreenController.verifyOtpApiCall();
                        otpScreenController.update();
                      },
                      width: double.infinity,
                      color: ColorSchema.primaryColor,
                      style: const TextStyle()
                          .normal16
                          .textColor(ColorSchema.whiteColor),
                      borderRadius: 5),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
