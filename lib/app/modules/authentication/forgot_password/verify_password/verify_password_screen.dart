import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/modules/authentication/forgot_password/forgot_password_controller.dart';
import 'package:linpo_user/app/modules/authentication/forgot_password/verify_password/verify_password_controller.dart';
import 'package:linpo_user/components/button/button.dart';
import 'package:linpo_user/components/common_container.dart';
import 'package:linpo_user/components/common_text_field.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/helper/utils/string_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VerifyPasswordScreen extends StatefulWidget {
  const VerifyPasswordScreen({Key? key}) : super(key: key);

  @override
  State<VerifyPasswordScreen> createState() => _VerifyPasswordScreenState();
}

class _VerifyPasswordScreenState extends State<VerifyPasswordScreen> {
  final verifyPasswordController =
      Get.put<VerifyPasswordController>(VerifyPasswordController());
  final forgotPasswordController = Get.find<ForgotPasswordController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: ColorSchema.whiteColor,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: GetBuilder<VerifyPasswordController>(
                init:  verifyPasswordController,
                builder: (controller) => 
                 Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: getSize(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: getSize(70),
                        ),
                        Text(AppLocalizations.of(Get.context!)!.resetPassword,
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
                            controller: verifyPasswordController.otpController,
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
                              setState(() {
                                verifyPasswordController.otp = pin;
                              });
                              verifyPasswordController.update();
                              print("Completed: " + pin);
                            }),
                        SizedBox(
                          height: getSize(20),
                        ),
                        Center(
                          child: TextButton(
                              onPressed: () {
                                // resendOtpApiCall();
                                forgotPasswordController.forgotPasswordApiCall();
                                forgotPasswordController.update();
                                verifyPasswordController.update();
                              },
                              child: Text(
                                AppLocalizations.of(Get.context!)!.resendOtp,
                                style: TextStyle()
                                    .medium16
                                    .textColor(ColorSchema.greenColor),
                              )),
                        ),
                        SizedBox(
                          height: getSize(40),
                        ),
                        TextfieldContainer(
                            widget: _newPasswordTextField(Get.context!)),
                        SizedBox(
                          height: getSize(5),
                        ),
                        FlutterPwValidator(
                          strings: SpanishString(),
                          controller:
                              verifyPasswordController.newPasswordController,
                          minLength: 8,
                          uppercaseCharCount: 1,
                          numericCharCount: 1,
                          width: 400,
                          height: 110,
                          onSuccess: () {
                          
                                verifyPasswordController
                                    .isNewPasswordValid.value = true;
                            
                            verifyPasswordController.update();
                          },
                          onFail: () {
                                verifyPasswordController
                                    .isNewPasswordValid.value = false;
                            verifyPasswordController.update();
                          },
                        ),
                        SizedBox(
                          height: getSize(18),
                        ),
                        TextfieldContainer(
                            widget: _confirmPasswordTextField(Get.context!)),
                        SizedBox(
                          height: getSize(40),
                        ),
                        CommonAppButton(
                            text:
                                AppLocalizations.of(Get.context!)!.resetPassword,
                            onTap: () {
                              setState(() {
                                if (formKey.currentState!.validate()) {
                                  FocusScope.of(context).unfocus();
                                  verifyPasswordController.resetPasswordApiCall();
                                } else {
                                  verifyPasswordController
                                      .isNewPasswordValid.value = false;
                                  verifyPasswordController
                                      .isConfirmPasswordValid.value = false;
                                }
                              });
                              verifyPasswordController.update();
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
          ),
        ),
      ),
    );
  }

  CommonTextField _newPasswordTextField(BuildContext context) {
    return CommonTextField(
      inputAction: TextInputAction.next,
      focusNode: verifyPasswordController.newPasswordFocusNode,
      function: () {
        verifyPasswordController.isShowNewPassword.value =
            !verifyPasswordController.isShowNewPassword.value;
      },
      textOption: TextFieldOption(
        inputController: verifyPasswordController.newPasswordController,
        isSecureTextField: !verifyPasswordController.isShowNewPassword.value,
        keyboardType: TextInputType.visiblePassword,
        labelText: AppLocalizations.of(context)!.newPassword,
        labelStyleText: verifyPasswordController.isNewPasswordValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      isEyeIcon: true,
      onNextPress: () {
        verifyPasswordController.confirmPasswordFocusNode.requestFocus();
      },
      validation: (val) {},
      textCallback: (String text) {
        verifyPasswordController.update();
      },
    );
  }

  CommonTextField _confirmPasswordTextField(BuildContext context) {
    return CommonTextField(
      inputAction: TextInputAction.done,
      focusNode: verifyPasswordController.confirmPasswordFocusNode,
      function: () {
        verifyPasswordController.isShowConfirmPassword.value =
            !verifyPasswordController.isShowConfirmPassword.value;
      },
      textOption: TextFieldOption(
        inputController: verifyPasswordController.confirmPasswordController,
        isSecureTextField:
            !verifyPasswordController.isShowConfirmPassword.value,
        keyboardType: TextInputType.visiblePassword,
        labelText: AppLocalizations.of(context)!.confirmPassword,
        labelStyleText: verifyPasswordController.isConfirmPasswordValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      isEyeIcon: true,
      validation: (val) {
        if (val!.isEmpty) {
          verifyPasswordController.isConfirmPasswordValid.value = false;
          return ""; //AppLocalizations.of(context)!.enterMinimumCharacter;
        }
        if (val != verifyPasswordController.newPasswordController.text) {
          verifyPasswordController.isConfirmPasswordValid.value = false;
          return "";
        } else {
          verifyPasswordController.isConfirmPasswordValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          verifyPasswordController.isConfirmPasswordValid.value = false;
        }
        if (val != verifyPasswordController.newPasswordController.text) {
          verifyPasswordController.isConfirmPasswordValid.value = false;
        } else {
          verifyPasswordController.isConfirmPasswordValid.value = true;
        }
        verifyPasswordController.update();
      },
    );
  }
}
