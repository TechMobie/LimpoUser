import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/modules/authentication/sign_In/sign_in_controller.dart';
import 'package:linpo_user/app/routes/app_pages.dart';
import 'package:linpo_user/components/button/button.dart';
import 'package:linpo_user/components/common_container.dart';
import 'package:linpo_user/components/common_text_field.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/helper/utils/images.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/helper/utils/string_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  final signInController = Get.put<SignInController>(SignInController());

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
              child: GetBuilder<SignInController>(
                init: signInController,
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
                        height: getSize(60),
                        color: ColorSchema.primaryColor,
                      ),
                      SizedBox(
                        height: getSize(18),
                      ),
                      Text(
                        AppLocalizations.of(context)!.logInText,
                        style: const TextStyle().medium20,
                      ),
                      SizedBox(
                        height: getSize(100),
                      ),
                      TextfieldContainer(widget: _emailTextField(context)),
                      SizedBox(
                        height: getSize(18),
                      ),
                      TextfieldContainer(widget: _passwordTextField(context)),
                      SizedBox(
                        height: getSize(18),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              AppLocalizations.of(context)!.didYouForget,
                              style: const TextStyle().normal16,
                            ),
                          ),
                          SizedBox(
                            width: getSize(5),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.forgot);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.clickHere,
                              style: const TextStyle()
                                  .normal16
                                  .textColor(ColorSchema.primaryColor),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: getSize(18),
                      ),
                      CommonAppButton(
                          text: AppLocalizations.of(context)!.logInText,
                          onTap: () async {
                            if (signInController
                                    .isSignInPasswordButtonValid.value &&
                                signInController
                                    .isSignInEmailButtonValid.value) {
                              if (formKey.currentState!.validate()) {
                                await signInController.logInApiCall();

                                if (kDebugMode) {
                                  print("Log In");
                                }
                              }
                            }
                          },
                          width: double.infinity,
                          color: signInController
                                      .isSignInPasswordButtonValid.value &&
                                  signInController
                                      .isSignInEmailButtonValid.value
                              ? ColorSchema.primaryColor
                              : ColorSchema.grey38Color,
                          style: const TextStyle()
                              .normal16
                              .textColor(ColorSchema.whiteColor),
                          borderRadius: 5),
                      SizedBox(
                        height: getSize(18),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              AppLocalizations.of(context)!.noAccount,
                              style: const TextStyle().normal16,
                            ),
                          ),
                          SizedBox(
                            width: getSize(10),
                          ),
                          GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.signUp);
                              },
                              child: Text(
                                AppLocalizations.of(context)!.signUpHere,
                                style: const TextStyle()
                                    .normal16
                                    .textColor(ColorSchema.primaryColor),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: getSize(20),
                      ),
                      GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.bottomBarScreen);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.guest,
                            style: const TextStyle()
                                .normal16
                                .textColor(ColorSchema.primaryColor),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: hideReturn == true
            ? const SizedBox()
            : SafeArea(
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
      inputAction: TextInputAction.next,
      focusNode: signInController.emailSignInFocusNode,
      textOption: TextFieldOption(
          inputController: signInController.emailSignInController,
          keyboardType: TextInputType.emailAddress,
          labelText: AppLocalizations.of(context)!.email,
          labelStyleText: signInController.isSignInEmailValid.value
              ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
              : const TextStyle().normal16.textColor(ColorSchema.redColor)),
      clearIcon:
          signInController.emailSignInController.text.isNotEmpty ? true : false,
      function: () {
        signInController.emailSignInController.clear();
        signInController.isSignInEmailValid.value = false;
        signInController.isSignInEmailButtonValid.value = false;
        signInController.update();
      },
      onNextPress: () {
        signInController.passwordSignInFocusNode.requestFocus();
      },
      validation: (val) {
        if (val!.isEmpty) {
          signInController.isSignInEmailValid.value = false;
          signInController.isSignInEmailButtonValid.value = false;
          return "";
        } else if (!ValidationUtils.validateEmail(val)) {
          signInController.isSignInEmailValid.value = false;
          signInController.isSignInEmailButtonValid.value = false;
          return "";
        } else {
          signInController.isSignInEmailValid.value = true;
          signInController.isSignInEmailButtonValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          signInController.isSignInEmailValid.value = false;
          signInController.isSignInEmailButtonValid.value = false;
        } else if (!ValidationUtils.validateEmail(val)) {
          signInController.isSignInEmailValid.value = false;
          signInController.isSignInEmailButtonValid.value = false;
        } else {
          signInController.isSignInEmailValid.value = true;
          signInController.isSignInEmailButtonValid.value = true;
        }
        signInController.update();
      },
    );
  }

  CommonTextField _passwordTextField(BuildContext context) {
    return CommonTextField(
      inputAction: TextInputAction.done,
      focusNode: signInController.passwordSignInFocusNode,
      textOption: TextFieldOption(
          isSecureTextField: true,
          inputController: signInController.passwordSignInController,
          keyboardType: TextInputType.visiblePassword,
          labelText: AppLocalizations.of(context)!.password,
          labelStyleText: signInController.isSignInPasswordValid.value
              ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
              : const TextStyle().normal16.textColor(ColorSchema.redColor)),
      function: () {
        signInController.passwordSignInController.clear();
        signInController.isSignInPasswordValid.value = false;
        signInController.isSignInPasswordButtonValid.value = false;
        signInController.update();
      },
      isEyeIcon: true,
      // clearIcon:
      //     authenticationController.passwordSignInController.text.isNotEmpty
      //         ? true
      //         : false,
      validation: (val) {
        if (val!.isEmpty) {
          signInController.isSignInPasswordValid.value = false;
          signInController.isSignInPasswordButtonValid.value = false;
          return "";
        } else {
          signInController.isSignInPasswordValid.value = true;
          signInController.isSignInPasswordButtonValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          signInController.isSignInPasswordValid.value = false;
          signInController.isSignInPasswordButtonValid.value = false;
        } else {
          signInController.isSignInPasswordValid.value = true;
          signInController.isSignInPasswordButtonValid.value = true;
        }
        signInController.update();
      },
    );
  }
}
