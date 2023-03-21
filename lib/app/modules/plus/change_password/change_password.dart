import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/modules/plus/change_password/change_password_controller.dart';
import 'package:linpo_user/components/button/button.dart';
import 'package:linpo_user/components/common_class.dart';
import 'package:linpo_user/components/common_container.dart';
import 'package:linpo_user/components/common_text_field.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/helper/utils/string_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final formKey = GlobalKey<FormState>();

  final changePasswordController =
      Get.put<ChangePasswordController>(ChangePasswordController());

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
                child: Obx(
                  () => Padding(
                    padding: EdgeInsets.symmetric(horizontal: getSize(15)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: getSize(20),
                        ),
                        CommonHeader(
                          title: AppLocalizations.of(context)!.changePassword,
                        ),
                        SizedBox(
                          height: getSize(35),
                        ),
                        TextfieldContainer(
                            widget: _oldPasswordTextField(context)),
                        SizedBox(
                          height: getSize(18),
                        ),
                        TextfieldContainer(
                            widget: _newPasswordTextField(context)),
                        SizedBox(
                          height: getSize(5),
                        ),
                        FlutterPwValidator(
                          strings: SpanishString(),
                          controller:
                              changePasswordController.newPasswordController,
                          minLength: 8,
                          uppercaseCharCount: 1,
                          numericCharCount: 1,
                          width: 400,
                          height: 110,
                          onSuccess: () {
                            changePasswordController.isNewPasswordValid.value =
                                true;
                            changePasswordController
                                .isNewPasswordButtonValid.value = true;
                            changePasswordController.update();
                          },
                          onFail: () {
                            changePasswordController.isNewPasswordValid.value =
                                false;
                            changePasswordController
                                .isNewPasswordButtonValid.value = false;
                            changePasswordController.update();
                          },
                        ),
                        SizedBox(
                          height: getSize(18),
                        ),
                        TextfieldContainer(
                            widget: _confirmPasswordTextField(context)),
                        SizedBox(
                          height: getSize(18),
                        ),
                        CommonButton(
                          borderRadius: 5,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 2,
                              color: ColorSchema.grey54Color,
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                     
                          buttonColor: buttonColor(),
                          text: AppLocalizations.of(context)!.update,
                          textStyle: const TextStyle()
                              .medium16
                              .textColor(ColorSchema.whiteColor),
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            if (formKey.currentState!.validate()) {
                              await changePasswordController
                                  .changePasswordApiCall();
                              if (kDebugMode) {
                                print('Update');
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  CommonTextField _oldPasswordTextField(BuildContext context) {
    return CommonTextField(
      inputAction: TextInputAction.next,
      focusNode: changePasswordController.oldPasswordFocusNode,
      function: () {
        changePasswordController.isShowOldPassword.value =
            !changePasswordController.isShowOldPassword.value;
      },
      textOption: TextFieldOption(
        inputController: changePasswordController.oldPasswordController,
        isSecureTextField: !changePasswordController.isShowOldPassword.value,
        keyboardType: TextInputType.visiblePassword,
        labelText: AppLocalizations.of(context)!.oldPassword,
        labelStyleText: changePasswordController.isOldPasswordValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      isEyeIcon: true,
      onNextPress: () {
        changePasswordController.newPasswordFocusNode.requestFocus();
      },
      validation: (val) {
        if (val!.isEmpty) {
          changePasswordController.isOldPasswordValid.value = false;
          changePasswordController.isOldPasswordButtonValid.value = false;
          return "";
        } else {
          changePasswordController.isOldPasswordValid.value = true;
          changePasswordController.isOldPasswordButtonValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          changePasswordController.isOldPasswordValid.value = false;
          changePasswordController.isOldPasswordButtonValid.value = false;
        } else {
          changePasswordController.isOldPasswordValid.value = true;
          changePasswordController.isOldPasswordButtonValid.value = true;
        }
        changePasswordController.update();
      },
    );
  }

  CommonTextField _newPasswordTextField(BuildContext context) {
    return CommonTextField(
      inputAction: TextInputAction.next,
      focusNode: changePasswordController.newPasswordFocusNode,
      function: () {
        changePasswordController.isShowNewPassword.value =
            !changePasswordController.isShowNewPassword.value;
      },
      textOption: TextFieldOption(
        inputController: changePasswordController.newPasswordController,
        isSecureTextField: !changePasswordController.isShowNewPassword.value,
        keyboardType: TextInputType.visiblePassword,
        labelText: AppLocalizations.of(context)!.newPassword,
        labelStyleText: changePasswordController.isNewPasswordValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      isEyeIcon: true,
      onNextPress: () {
        changePasswordController.confirmPasswordFocusNode.requestFocus();
      },
      validation: (val) {},
      textCallback: (String text) {},
    );
  }

  CommonTextField _confirmPasswordTextField(BuildContext context) {
    return CommonTextField(
      inputAction: TextInputAction.done,
      focusNode: changePasswordController.confirmPasswordFocusNode,
      function: () {
        changePasswordController.isShowConfirmPassword.value =
            !changePasswordController.isShowConfirmPassword.value;
      },
      textOption: TextFieldOption(
        inputController: changePasswordController.confirmPasswordController,
        isSecureTextField:
            !changePasswordController.isShowConfirmPassword.value,
        keyboardType: TextInputType.visiblePassword,
        labelText: AppLocalizations.of(context)!.confirmPassword,
        labelStyleText: changePasswordController.isConfirmPasswordValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      isEyeIcon: true,
      validation: (val) {
        if (val!.isEmpty) {
          changePasswordController.isConfirmPasswordValid.value = false;
          changePasswordController.isConfirmPasswordButtonValid.value = false;
          return ""; //AppLocalizations.of(context)!.enterMinimumCharacter;
        }
        if (val != changePasswordController.newPasswordController.text) {
          changePasswordController.isConfirmPasswordValid.value = false;
          changePasswordController.isConfirmPasswordButtonValid.value = false;
          return "";
        } else {
          changePasswordController.isConfirmPasswordValid.value = true;
          changePasswordController.isConfirmPasswordButtonValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          changePasswordController.isConfirmPasswordValid.value = false;
          changePasswordController.isConfirmPasswordButtonValid.value = false;
        }
        if (val != changePasswordController.newPasswordController.text) {
          changePasswordController.isConfirmPasswordValid.value = false;
          changePasswordController.isConfirmPasswordButtonValid.value = false;
        } else {
          changePasswordController.isConfirmPasswordValid.value = true;
          changePasswordController.isConfirmPasswordButtonValid.value = true;
        }
        changePasswordController.update();
      },
    );
  }

//update button color....
  Color buttonColor() {
    if (changePasswordController.isOldPasswordButtonValid.value &&
        changePasswordController.isNewPasswordButtonValid.value &&
        changePasswordController.isConfirmPasswordButtonValid.value) {
      return ColorSchema.greenColor;
    } else {
      return ColorSchema.grey38Color;
    }
  }
}
