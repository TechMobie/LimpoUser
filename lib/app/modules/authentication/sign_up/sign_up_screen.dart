import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:linpo_user/app/modules/authentication/sign_up/sign_up_controller.dart';
import 'package:linpo_user/app/routes/app_pages.dart';
import 'package:linpo_user/components/button/button.dart';
import 'package:linpo_user/components/common_container.dart';
import 'package:linpo_user/components/common_text_field.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/helper/utils/images.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/helper/utils/rutTextfield.dart';
import 'package:linpo_user/helper/utils/string_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final signUpController = Get.put<SignUpController>(SignUpController());
 

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
              child: GetBuilder<SignUpController>(
                init: signUpController,
                builder: (controller) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: getSize(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: getSize(30),
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
                        AppLocalizations.of(context)!.enterYourData,
                        style: const TextStyle().medium20,
                      ),
                      SizedBox(
                        height: getSize(30),
                      ),
                      TextfieldContainer(widget: _firstNameTextField(context)),
                      SizedBox(
                        height: getSize(18),
                      ),
                      TextfieldContainer(widget: _lastNameTextField(context)),
                      SizedBox(
                        height: getSize(18),
                      ),
                      TextfieldContainer(widget: _rutTextField(context)),
                      SizedBox(
                        height: getSize(18),
                      ),
                      TextfieldContainer(widget: _emailTextField(context)),
                      SizedBox(
                        height: getSize(18),
                      ),
                      TextfieldContainer(
                          widget: _confirmEmailTextField(context)),
                      SizedBox(
                        height: getSize(18),
                      ),
                      TextfieldContainer(
                          widget: _phoneNumberTextField(context)),
                      SizedBox(
                        height: getSize(10),
                      ),
                      TextfieldContainer(widget: _birthDateTextField(context)),
                      SizedBox(
                        height: getSize(18),
                      ),
                      TextfieldContainer(widget: _passwordTextField(context)),
                      SizedBox(
                        height: getSize(5),
                      ),
                      FlutterPwValidator(
                        strings: SpanishString(),
                        controller: signUpController.passwordSignUpController,
                        minLength: 8,
                        uppercaseCharCount: 1,
                        numericCharCount: 1,
                        width: 400,
                        height: 103,
                        successColor: ColorSchema.greenColor,
                        onSuccess: () {
                          if (kDebugMode) {
                            print("MATCHED");
                          }
                          signUpController.isSignUpPasswordValid.value = true;
                          signUpController.isSignUpPasswordButtonValid.value =
                              true;
                          signUpController.update();
                        },
                        onFail: () {
                          signUpController.isSignUpPasswordValid.value = false;
                          signUpController.isSignUpPasswordButtonValid.value =
                              false;
                          signUpController.update();
                        },
                      ),
                      SizedBox(
                        height: getSize(18),
                      ),
                      TextfieldContainer(
                          widget: _repeatPasswordTextField(context)),
                      SizedBox(
                        height: getSize(18),
                      ),
                      Obx(
                        () => GestureDetector(
                          onTap: () {
                            signUpController.isReceiveCheckBox.value =
                                !signUpController.isReceiveCheckBox.value;
                            signUpController.update();
                          },
                          child: Row(
                            children: [
                              Container(
                                child: signUpController.isReceiveCheckBox.value
                                    ? const Icon(
                                        Icons.check_box,
                                        size: 25.0,
                                        color: ColorSchema.greenColor,
                                      )
                                    : const Icon(
                                        Icons.check_box_outline_blank,
                                        size: 25.0,
                                        color: ColorSchema.grey54Color,
                                      ),
                              ),
                              SizedBox(
                                width: getSize(7),
                              ),
                              Flexible(
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .iWantToReceiveEmailsAndPromotions,
                                  style: const TextStyle()
                                      .normal16
                                      .textColor(ColorSchema.blackColor),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getSize(15),
                      ),
                      Obx(
                        () => GestureDetector(
                          onTap: () {
                            signUpController.isConditionCheckBox.value =
                                !signUpController.isConditionCheckBox.value;
                            signUpController.update();
                          },
                          child: Row(
                            children: [
                              Container(
                                child:
                                    signUpController.isConditionCheckBox.value
                                        ? const Icon(
                                            Icons.check_box,
                                            size: 25.0,
                                            color: ColorSchema.greenColor,
                                          )
                                        : const Icon(
                                            Icons.check_box_outline_blank,
                                            size: 25.0,
                                            color: ColorSchema.grey54Color,
                                          ),
                              ),
                              SizedBox(
                                width: getSize(7),
                              ),
                              Flexible(
                                child: RichText(
                                  text: TextSpan(
                                    text: "${AppLocalizations.of(context)!
                                            .iHaveRead} ",
                                    style: const TextStyle()
                                        .normal16
                                        .textColor(ColorSchema.blackColor),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .termsAndConditions,
                                        style: const TextStyle()
                                            .normal16
                                            .textColor(ColorSchema.greenColor),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Get.toNamed(Routes.termsCondition);
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getSize(18),
                      ),
                      CommonAppButton(
                          text: AppLocalizations.of(context)!.createAccount,
                          onTap: () async {
                            if (formKey.currentState!.validate() &&
                                signUpController.isConditionCheckBox.value) {
                              await signUpController.signUpApiCall();

                              if (kDebugMode) {
                                print('Sign Up');
                              }
                            } else if (!signUpController
                                .isConditionCheckBox.value) {
                              showToast(
                                msg: AppLocalizations.of(context)!
                                    .pleaseConditions,
                                color: ColorSchema.redColor.withOpacity(0.3),
                              );
                            }
                          },
                          width: double.infinity,
                          color: signUpController
                                      .isSignUpEmailButtonValid.value &&
                                  signUpController
                                      .isConfirmSignUpEmailButtonValid.value &&
                                  signUpController
                                      .isSignUpPasswordButtonValid.value &&
                                  signUpController
                                      .isSignUpFirstNameButtonValid.value &&
                                  signUpController
                                      .isSignUpLastNameButtonValid.value &&
                                  signUpController
                                      .isSignUpRepeatPasswordButtonValid
                                      .value &&
                                  // authenticationController
                                  //     .isSignUpPhoneNumberButtonValid.value &&
                                  // authenticationController
                                  //     .isSignUpDobButtonValid.value &&
                                  // authenticationController
                                  //     .isSignUpRutButtonValid.value &&
                                  signUpController.isConditionCheckBox.value
                              ? ColorSchema.primaryColor
                              : ColorSchema.grey38Color,
                          style: const TextStyle()
                              .normal16
                              .textColor(ColorSchema.whiteColor),
                          borderRadius: 5),
                      SizedBox(
                        height: getSize(20),
                      ),
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

  CommonTextField _firstNameTextField(BuildContext context) {
    return CommonTextField(
      inputAction: TextInputAction.next,
      focusNode: signUpController.firstNameSignUpFocusNode,
      textOption: TextFieldOption(
        inputController: signUpController.firstNameSignUpController,
        keyboardType: TextInputType.name,
        labelText: AppLocalizations.of(context)!.firstName,
        labelStyleText: signUpController.isSignUpFirstNameValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      clearIcon: signUpController.firstNameSignUpController.text.isNotEmpty
          ? true
          : false,
      function: () {
        signUpController.firstNameSignUpController.clear();
        signUpController.isSignUpFirstNameValid.value = false;
        signUpController.isSignUpFirstNameButtonValid.value = false;
        signUpController.update();
      },
      onNextPress: () {
        signUpController.lastNameSignUpFocusNode.requestFocus();
      },
      validation: (val) {
        if (val!.isEmpty) {
          signUpController.isSignUpFirstNameValid.value = false;
          signUpController.isSignUpFirstNameButtonValid.value = false;
          return "";
        } else {
          signUpController.isSignUpFirstNameValid.value = true;
          signUpController.isSignUpFirstNameButtonValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          signUpController.isSignUpFirstNameValid.value = false;
          signUpController.isSignUpFirstNameButtonValid.value = false;
        } else {
          signUpController.isSignUpFirstNameValid.value = true;
          signUpController.isSignUpFirstNameButtonValid.value = true;
        }
        signUpController.update();
      },
    );
  }

  CommonTextField _lastNameTextField(BuildContext context) {
    return CommonTextField(
      inputAction: TextInputAction.next,
      focusNode: signUpController.lastNameSignUpFocusNode,
      textOption: TextFieldOption(
        inputController: signUpController.lastNameSignUpController,
        keyboardType: TextInputType.name,
        labelText: AppLocalizations.of(context)!.lastName,
        labelStyleText: signUpController.isSignUpLastNameValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      clearIcon: signUpController.lastNameSignUpController.text.isNotEmpty
          ? true
          : false,
      function: () {
        signUpController.lastNameSignUpController.clear();
        signUpController.isSignUpLastNameValid.value = false;
        signUpController.isSignUpLastNameButtonValid.value = false;
        signUpController.update();
      },
      onNextPress: () {
        signUpController.rutFocusNode.requestFocus();
      },
      validation: (val) {
        if (val!.isEmpty) {
          signUpController.isSignUpLastNameValid.value = false;
          signUpController.isSignUpLastNameButtonValid.value = false;
          return "";
        } else {
          signUpController.isSignUpLastNameValid.value = true;
          signUpController.isSignUpLastNameButtonValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          signUpController.isSignUpLastNameValid.value = false;
          signUpController.isSignUpLastNameButtonValid.value = false;
        } else {
          signUpController.isSignUpLastNameValid.value = true;
          signUpController.isSignUpLastNameButtonValid.value = true;
        }
        signUpController.update();
      },
    );
  }

  CommonTextField _rutTextField(BuildContext context) {
    return CommonTextField(
      inputAction: TextInputAction.next,
      focusNode: signUpController.rutFocusNode,
      textOption: TextFieldOption(
        inputController: signUpController.rutSignUpController,
        keyboardType: TextInputType.visiblePassword,
        labelText: AppLocalizations.of(context)!.ruts,
        labelStyleText: signUpController.isSignUpRutValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      clearIcon:
          signUpController.rutSignUpController.text.isNotEmpty ? true : false,
      onNextPress: () {
        signUpController.emailSignUpFocusNode.requestFocus();
      },
      function: () {
        signUpController.rutSignUpController.clear();
        signUpController.isSignUpRutValid.value = false;
        // authenticationController.isSignUpRutButtonValid.value = false;
        signUpController.update();
      },
      validation: (val) {
        RUTValidator(
                validationErrorText: AppLocalizations.of(context)!.enterRut)
            .validator;
        if (val!.isNotEmpty) {
          signUpController.isSignUpRutValid.value = false;
          // authenticationController.isSignUpRutButtonValid.value = false;
          if (!ValidationUtils.validateRut(val)) {
            signUpController.isSignUpRutValid.value = true;
            // authenticationController.isSignUpRutButtonValid.value = true;
            return "";
          } else {
            signUpController.isSignUpRutValid.value = true;
            // authenticationController.isSignUpRutButtonValid.value = true;
            return null;
          }
        }
        signUpController.update();
      },
      textCallback: (val) {
        RUTValidator.formatFromTextController(
            signUpController.rutSignUpController);
        signUpController.update();
        if (val.isNotEmpty) {
          signUpController.isSignUpRutValid.value = false;
          // authenticationController.isSignUpRutButtonValid.value = false;
          if (!ValidationUtils.validateRut(val)) {
            signUpController.isSignUpRutValid.value = true;
            // authenticationController.isSignUpRutButtonValid.value = true;
          } else {
            signUpController.isSignUpRutValid.value = true;
            // authenticationController.isSignUpRutButtonValid.value = true;
          }
        }
        signUpController.update();
      },
    );
  }

  CommonTextField _emailTextField(BuildContext context) {
    return CommonTextField(
      inputAction: TextInputAction.next,
      focusNode: signUpController.emailSignUpFocusNode,
      textOption: TextFieldOption(
        inputController: signUpController.emailSignUpController,
        keyboardType: TextInputType.emailAddress,
        labelText: AppLocalizations.of(context)!.emailAddress,
        labelStyleText: signUpController.isSignUpEmailValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      clearIcon:
          signUpController.emailSignUpController.text.isNotEmpty ? true : false,
      function: () {
        signUpController.emailSignUpController.clear();
        signUpController.isSignUpEmailValid.value = false;
        signUpController.isSignUpEmailButtonValid.value = false;
        signUpController.update();
      },
      onNextPress: () {
        signUpController.confirmEmailSignUpFocusNode.requestFocus();
      },
      validation: (val) {
        if (val!.isEmpty) {
          signUpController.isSignUpEmailValid.value = false;
          signUpController.isSignUpEmailButtonValid.value = false;
          return "";
        } else if (!ValidationUtils.validateEmail(val)) {
          signUpController.isSignUpEmailValid.value = false;
          signUpController.isSignUpEmailButtonValid.value = false;
          return "";
        } else {
          signUpController.isSignUpEmailValid.value = true;
          signUpController.isSignUpEmailButtonValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          signUpController.isSignUpEmailValid.value = false;
          signUpController.isSignUpEmailButtonValid.value = false;
        } else if (!ValidationUtils.validateEmail(val)) {
          signUpController.isSignUpEmailValid.value = false;
          signUpController.isSignUpEmailButtonValid.value = false;
        } else {
          signUpController.isSignUpEmailValid.value = true;
          signUpController.isSignUpEmailButtonValid.value = true;
        }
        signUpController.update();
      },
    );
  }

  CommonTextField _confirmEmailTextField(BuildContext context) {
    return CommonTextField(
      inputAction: TextInputAction.next,
      focusNode: signUpController.confirmEmailSignUpFocusNode,
      textOption: TextFieldOption(
        inputController: signUpController.confirmEmailSignUpController,
        keyboardType: TextInputType.emailAddress,
        labelText: AppLocalizations.of(context)!.confirmEmailAddress,
        labelStyleText: signUpController.isConfirmSignUpEmailValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      clearIcon: signUpController.confirmEmailSignUpController.text.isNotEmpty
          ? true
          : false,
      function: () {
        signUpController.confirmEmailSignUpController.clear();
        signUpController.isConfirmSignUpEmailValid.value = false;
        signUpController.isConfirmSignUpEmailButtonValid.value = false;
        signUpController.update();
      },
      onNextPress: () {
        signUpController.phoneNumberSignUpFocusNode.requestFocus();
      },
      validation: (val) {
        if (val!.isEmpty) {
          signUpController.isConfirmSignUpEmailValid.value = false;
          signUpController.isConfirmSignUpEmailButtonValid.value = false;
          return "";
        }
        if (val != signUpController.emailSignUpController.text) {
          signUpController.isConfirmSignUpEmailValid.value = false;
          signUpController.isConfirmSignUpEmailButtonValid.value = false;
          return "";
        } else {
          signUpController.isConfirmSignUpEmailValid.value = true;
          signUpController.isConfirmSignUpEmailButtonValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          signUpController.isConfirmSignUpEmailValid.value = false;
          signUpController.isConfirmSignUpEmailButtonValid.value = false;
        }
        if (val != signUpController.emailSignUpController.text) {
          signUpController.isConfirmSignUpEmailValid.value = false;
          signUpController.isConfirmSignUpEmailButtonValid.value = false;
        } else {
          signUpController.isConfirmSignUpEmailValid.value = true;
          signUpController.isConfirmSignUpEmailButtonValid.value = true;
        }
        signUpController.update();
      },
    );
  }

  CommonTextField _phoneNumberTextField(BuildContext context) {
    return CommonTextField(
      inputAction: TextInputAction.next,
      focusNode: signUpController.phoneNumberSignUpFocusNode,
      textOption: TextFieldOption(
        // maxLength: 9,
        prefixWid: Text('+56',
            style:
                const TextStyle().normal16.textColor(ColorSchema.grey54Color)),
        inputController: signUpController.phoneNumberSignUpController,
        keyboardType: TextInputType.number,
        labelText: AppLocalizations.of(context)!.phoneNumber,
        labelStyleText: signUpController.isSignUpPhoneNumberValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      clearIcon: false,
      onNextPress: () {
        signUpController.dobSignUpFocusNode.requestFocus();
      },
      validation: (val) {
        if (val!.isNotEmpty) {
          signUpController.isSignUpPhoneNumberValid.value = false;
          // authenticationController.isSignUpPhoneNumberButtonValid.value = false;
          if (val.length != 9) {
            signUpController.isSignUpPhoneNumberValid.value = false;
            // authenticationController.isSignUpPhoneNumberButtonValid.value = false;
            return "";
          }
        } else {
          signUpController.isSignUpPhoneNumberValid.value = true;
          // authenticationController.isSignUpPhoneNumberButtonValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isNotEmpty) {
          signUpController.isSignUpPhoneNumberValid.value = false;
          // authenticationController.isSignUpPhoneNumberButtonValid.value = false;
          if (val.length != 9) {
            signUpController.isSignUpPhoneNumberValid.value = false;
            // authenticationController.isSignUpPhoneNumberButtonValid.value = false;
          } else {
            signUpController.isSignUpPhoneNumberValid.value = true;
            // authenticationController.isSignUpPhoneNumberButtonValid.value = true;
          }
        } else {
          signUpController.isSignUpPhoneNumberValid.value = true;
          // authenticationController.isSignUpPhoneNumberButtonValid.value = true;
        }
        signUpController.update();
      },
    );
  }

  TextFormField _birthDateTextField(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      focusNode: signUpController.dobSignUpFocusNode,
      controller: signUpController.dobSignUpController,
      decoration: InputDecoration(
          isDense: true,
          // contentPadding: EdgeInsets.symmetric(horizontal: getSize(10)),
          labelText: AppLocalizations.of(context)!.dob,
          // labelStyle: authenticationController.isSignUpDobValid.value
          labelStyle:
              const TextStyle().normal16.textColor(ColorSchema.grey54Color),
          // : const TextStyle().normal16.textColor(ColorSchema.redColor),
          errorStyle: const TextStyle(height: 0),
          border: InputBorder.none,
          suffixIcon: Icon(Icons.calendar_today, size: getSize(25))),
      onFieldSubmitted: (String text) {
        FocusScope.of(context).unfocus();
        signUpController.passwordSignUpFocusNode.requestFocus();
      },
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        // Show Date Picker Here
        await _selectDate(context);
        signUpController.dobSignUpController.text =
            DateFormat('yyyy-MM-dd').format(signUpController.selectedDate);
        // authenticationController.isSignUpDobValid.value = true;
        // authenticationController.isSignUpDobButtonValid.value = true;
        signUpController.update();
      },
      validator: (val) {
        return null;
      
        // if (val!.isNotEmpty) {
        //   authenticationController.isSignUpDobValid.value = false;
        //   // authenticationController.isSignUpDobButtonValid.value = false;
        //   return "";
        // } else {
        //   authenticationController.isSignUpDobValid.value = true;
        //   // authenticationController.isSignUpDobButtonValid.value = true;
        //   return null;
        // }
      },
      onChanged: (val) {
        // if (val.isNotEmpty) {
        //   authenticationController.isSignUpDobValid.value = false;
        //   // authenticationController.isSignUpDobButtonValid.value = false;
        // } else {
        //   authenticationController.isSignUpDobValid.value = true;
        //   // authenticationController.isSignUpDobButtonValid.value = true;
        // }
        signUpController.update();
      },
    );
  }

  CommonTextField _passwordTextField(BuildContext context) {
    return CommonTextField(
      inputAction: TextInputAction.next,
      focusNode: signUpController.passwordSignUpFocusNode,
      textOption: TextFieldOption(
        isSecureTextField: true,
        inputController: signUpController.passwordSignUpController,
        keyboardType: TextInputType.visiblePassword,
        labelText: AppLocalizations.of(context)!.password,
        labelStyleText: signUpController.isSignUpPasswordValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      isEyeIcon: true,
      // clearIcon:
      //     authenticationController.passwordSignUpController.text.isNotEmpty
      //         ? true
      //         : false,
      function: () {
        signUpController.passwordSignUpController.clear();
        signUpController.isSignUpPasswordValid.value = false;
        signUpController.isSignUpPasswordButtonValid.value = false;
        signUpController.update();
      },
      onNextPress: () {
        signUpController.repeatPasswordSignUpFocusNode.requestFocus();
        if (kDebugMode) {
          print("next");
        }
      },
      validation: (val) {},
      textCallback: (String text) {},
    );
  }

  CommonTextField _repeatPasswordTextField(BuildContext context) {
    return CommonTextField(
      inputAction: TextInputAction.done,
      focusNode: signUpController.repeatPasswordSignUpFocusNode,
      textOption: TextFieldOption(
        isSecureTextField: true,
        inputController: signUpController.repeatPasswordSignUpController,
        keyboardType: TextInputType.visiblePassword,
        labelText: AppLocalizations.of(context)!.repeatPassword,
        labelStyleText: signUpController.isSignUpRepeatPasswordValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      isEyeIcon: true,
      // clearIcon: authenticationController
      //         .repeatPasswordSignUpController.text.isNotEmpty
      //     ? true
      //     : false,
      function: () {
        signUpController.repeatPasswordSignUpController.clear();
        signUpController.isSignUpRepeatPasswordValid.value = false;
        signUpController.isSignUpRepeatPasswordButtonValid.value = false;
        signUpController.update();
      },
      validation: (val) {
        if (val!.isEmpty) {
          signUpController.isSignUpRepeatPasswordValid.value = false;
          signUpController.isSignUpRepeatPasswordButtonValid.value = false;
          return "";
        }
        if (val != signUpController.passwordSignUpController.text) {
          signUpController.isSignUpRepeatPasswordValid.value = false;
          signUpController.isSignUpRepeatPasswordButtonValid.value = false;
          return "";
        } else {
          signUpController.isSignUpRepeatPasswordValid.value = true;
          signUpController.isSignUpRepeatPasswordButtonValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          signUpController.isSignUpRepeatPasswordValid.value = false;
          signUpController.isSignUpRepeatPasswordButtonValid.value = false;
        }
        if (val != signUpController.passwordSignUpController.text) {
          signUpController.isSignUpRepeatPasswordValid.value = false;
          signUpController.isSignUpRepeatPasswordButtonValid.value = false;
        } else {
          signUpController.isSignUpRepeatPasswordValid.value = true;
          signUpController.isSignUpRepeatPasswordButtonValid.value = true;
        }
        signUpController.update();
      },
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme:
                const ColorScheme.light(primary: ColorSchema.primaryColor),
          ),
          child: child ?? const Text(""),
        );
      },
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selected != null && selected != signUpController.selectedDate) {
      signUpController.selectedDate = selected;
      // authenticationController.isSignUpDobValid.value = true;
    }
  }
}
