import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/modules/authentication/forgot_password/forgot_password_controller.dart';
import 'package:linpo_user/components/button/button.dart';
import 'package:linpo_user/components/common_container.dart';
import 'package:linpo_user/components/common_text_field.dart';
import 'package:linpo_user/helper/utils/images.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/helper/utils/string_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({Key? key}) : super(key: key);

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final formKey = GlobalKey<FormState>();
  final forgotPasswordController =
      Get.put<ForgotPasswordController>(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: ColorSchema.whiteColor,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: GetBuilder<ForgotPasswordController>(
                init: forgotPasswordController,
                builder: (controller) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: getSize(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: getSize(100),
                      ),
                      SvgPicture.asset(
                        ImageConstants.appIcon,
                        height: getSize(40),
                        color: ColorSchema.primaryColor,
                      ),
                      SizedBox(
                        height: getSize(18),
                      ),
                      Text(
                        AppLocalizations.of(context)!.recoverPassword,
                        style: const TextStyle().medium20,
                      ),
                      SizedBox(
                        height: getSize(100),
                      ),
                      TextfieldContainer(widget: _emailTextField(context)),
                      SizedBox(
                        height: getSize(18),
                      ),
                      CommonAppButton(
                          text: AppLocalizations.of(context)!.forgotPassword,
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            if (formKey.currentState!.validate()) {
                              await forgotPasswordController
                                  .forgotPasswordApiCall();
                              if (kDebugMode) {
                                print("Forgot Password");
                              }
                            }
                          },
                          width: double.infinity,
                          color: forgotPasswordController
                                  .isForgotEmailButtonValid.value
                              ? ColorSchema.primaryColor
                              : ColorSchema.grey38Color,
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
        ),
        bottomNavigationBar: SafeArea(
          child: BottomContainer(
            align: Alignment.center,
            name: AppLocalizations.of(context)!.returnText,
            icon: true,
            onTap: () {
              Get.back();
            },
          ),
        ),
      ),
    );
  }

  CommonTextField _emailTextField(BuildContext context) {
    return CommonTextField(
      inputAction: TextInputAction.done,
      focusNode: forgotPasswordController.emailForgotFocusNode,
      textOption: TextFieldOption(
        inputController: forgotPasswordController.emailForgotController,
        keyboardType: TextInputType.emailAddress,
        labelText: AppLocalizations.of(context)!.email,
        labelStyleText: forgotPasswordController.isForgotEmailValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      clearIcon: forgotPasswordController.emailForgotController.text.isNotEmpty
          ? true
          : false,
      function: () {
        forgotPasswordController.emailForgotController.clear();
        forgotPasswordController.isForgotEmailValid.value = false;
        forgotPasswordController.isForgotEmailButtonValid.value = false;
        forgotPasswordController.update();
      },
      validation: (val) {
        if (val!.isEmpty) {
          forgotPasswordController.isForgotEmailValid.value = false;
          forgotPasswordController.isForgotEmailButtonValid.value = false;
          return "";
        } else if (!ValidationUtils.validateEmail(val)) {
          forgotPasswordController.isForgotEmailValid.value = false;
          forgotPasswordController.isForgotEmailButtonValid.value = false;
          return "";
        } else {
          forgotPasswordController.isForgotEmailValid.value = true;
          forgotPasswordController.isForgotEmailButtonValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          forgotPasswordController.isForgotEmailValid.value = false;
          forgotPasswordController.isForgotEmailButtonValid.value = false;
        } else if (!ValidationUtils.validateEmail(val)) {
          forgotPasswordController.isForgotEmailValid.value = false;
          forgotPasswordController.isForgotEmailButtonValid.value = false;
        } else {
          forgotPasswordController.isForgotEmailValid.value = true;
          forgotPasswordController.isForgotEmailButtonValid.value = true;
        }
        forgotPasswordController.update();
      },
    );
  }
}
