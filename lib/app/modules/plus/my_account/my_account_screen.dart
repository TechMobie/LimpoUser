import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:linpo_user/app/modules/plus/my_account/my_account_controller.dart';
import 'package:linpo_user/components/button/button.dart';
import 'package:linpo_user/components/common_class.dart';
import 'package:linpo_user/components/common_container.dart';
import 'package:linpo_user/components/common_text_field.dart';
import 'package:linpo_user/helper/utils/images.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/helper/utils/rutTextfield.dart';
import 'package:linpo_user/helper/utils/string_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  final formKey = GlobalKey<FormState>();
  final myAccountController =
      Get.put<MyAccountController>(MyAccountController());

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
                          title: AppLocalizations.of(context)!.myAccount),
                      SizedBox(
                        height: getSize(35),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              AppLocalizations.of(context)!.personalInformation,
                              style: const TextStyle()
                                  .bold20
                                  .textColor(ColorSchema.blackColor),
                            ),
                          ),
                          if (myAccountController.isEdit.value == false)
                            GestureDetector(
                              onTap: () {
                                myAccountController.isEdit.value = true;
                              },
                              child: Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.editAccount,
                                    style: const TextStyle()
                                        .normal18
                                        .textColor(ColorSchema.greenColor),
                                  ),
                                  SizedBox(
                                    width: getSize(5),
                                  ),
                                  SvgPicture.asset(
                                    ImageConstants.edit,
                                    height: 20,
                                    width: 20,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: getSize(18),
                      ),
                      TextfieldContainer(widget: _nameTextField(context)),
                      SizedBox(
                        height: getSize(18),
                      ),
                      TextfieldContainer(widget: _lastNameTextField(context)),
                      SizedBox(
                        height: getSize(18),
                      ),
                      TextfieldContainer(widget: _emailTextField(context)),
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
                      TextfieldContainer(widget: _rutTextField(context)),
                      SizedBox(
                        height: getSize(30),
                      ),
                      if (myAccountController.isEdit.value)
                        Row(
                          children: [
                            Expanded(
                              child: CommonButton(
                                buttonColor: ColorSchema.whiteColor,
                                borderRadius: 5,
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 2,
                                    color: ColorSchema.grey54Color,
                                    offset: Offset(2.0, 2.0),
                                  ),
                                ],
                                text: AppLocalizations.of(context)!.cancel,
                                textStyle: const TextStyle()
                                    .medium16
                                    .textColor(ColorSchema.blackColor),
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  myAccountController.isEdit.value = false;
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: CommonButton(
                                borderRadius: 5,
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 2,
                                    color: ColorSchema.grey54Color,
                                    offset: Offset(2.0, 2.0),
                                  ),
                                ],
                                buttonColor: buttonColor(),
                                text: AppLocalizations.of(context)!.toUpdate,
                                textStyle: const TextStyle()
                                    .medium16
                                    .textColor(ColorSchema.whiteColor),
                                onTap: () async {
                                  FocusScope.of(context).unfocus();
                                  if (formKey.currentState!.validate()) {
                                    await myAccountController
                                        .editProfileApiCall();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      SizedBox(
                        height: getSize(18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
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
    if (selected != null && selected != myAccountController.selectedDate) {
      myAccountController.selectedDate = selected;
      // plusController.isDobValid.value = true;
    }
  }

  CommonTextField _nameTextField(BuildContext context) {
    return CommonTextField(
      isEditable: myAccountController.isEdit.value,
      inputAction: TextInputAction.next,
      focusNode: myAccountController.myNameFocusNode,
      textOption: TextFieldOption(
        inputController: myAccountController.myNameController,
        keyboardType: TextInputType.name,
        labelText: AppLocalizations.of(context)!.firstName,
        labelStyleText: myAccountController.isNameValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      clearIcon: false,
      onNextPress: () {
        myAccountController.myLastNameFocusNode.requestFocus();
      },
      validation: (val) {
        if (val!.isEmpty) {
          myAccountController.isNameValid.value = false;
          myAccountController.isNameButtonValid.value = false;
          return ""; //AppLocalizations.of(context)!.enterName;
        } else {
          myAccountController.isNameValid.value = true;
          myAccountController.isNameButtonValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          myAccountController.isNameValid.value = false;
          myAccountController.isNameButtonValid.value = false;
        } else {
          myAccountController.isNameValid.value = true;
          myAccountController.isNameButtonValid.value = true;
        }
        myAccountController.update();
      },
    );
  }

  CommonTextField _lastNameTextField(BuildContext context) {
    return CommonTextField(
      isEditable: myAccountController.isEdit.value,
      inputAction: TextInputAction.next,
      focusNode: myAccountController.myLastNameFocusNode,
      textOption: TextFieldOption(
        inputController: myAccountController.myLastNameController,
        keyboardType: TextInputType.name,
        labelText: AppLocalizations.of(context)!.lastName,
        labelStyleText: myAccountController.isLastNameValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      clearIcon: false,
      onNextPress: () {
        myAccountController.myEmailFocusNode.requestFocus();
      },
      validation: (val) {
        if (val!.isEmpty) {
          myAccountController.isLastNameValid.value = false;
          myAccountController.isLastNameButtonValid.value = false;
          return "";
        } else {
          myAccountController.isLastNameValid.value = true;
          myAccountController.isLastNameButtonValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          myAccountController.isLastNameValid.value = false;
          myAccountController.isLastNameButtonValid.value = false;
        } else {
          myAccountController.isLastNameValid.value = true;
          myAccountController.isLastNameButtonValid.value = true;
        }
        myAccountController.update();
      },
    );
  }

  CommonTextField _emailTextField(BuildContext context) {
    return CommonTextField(
      isEditable: myAccountController.isEdit.value,
      inputAction: TextInputAction.next,
      focusNode: myAccountController.myEmailFocusNode,
      textOption: TextFieldOption(
        inputController: myAccountController.myEmailController,
        keyboardType: TextInputType.emailAddress,
        labelText: AppLocalizations.of(context)!.email,
        labelStyleText: myAccountController.isEmailValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      clearIcon: false,
      onNextPress: () {
        myAccountController.myPhoneNumberFocusNode.requestFocus();
      },
      validation: (val) {
        if (val!.isEmpty) {
          myAccountController.isEmailValid.value = false;
          myAccountController.isEmailButtonValid.value = false;
          return "";
        } else if (!ValidationUtils.validateEmail(val)) {
          myAccountController.isEmailValid.value = false;
          myAccountController.isEmailButtonValid.value = false;
          return "";
        } else {
          myAccountController.isEmailValid.value = true;
          myAccountController.isEmailButtonValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          myAccountController.isEmailValid.value = false;
          myAccountController.isEmailButtonValid.value = false;
        } else if (!ValidationUtils.validateEmail(val)) {
          myAccountController.isEmailValid.value = false;
          myAccountController.isEmailButtonValid.value = false;
        } else {
          myAccountController.isEmailValid.value = true;
          myAccountController.isEmailButtonValid.value = true;
        }
        myAccountController.update();
      },
    );
  }

  CommonTextField _phoneNumberTextField(BuildContext context) {
    return CommonTextField(
      isEditable: myAccountController.isEdit.value,
      inputAction: TextInputAction.next,
      focusNode: myAccountController.myPhoneNumberFocusNode,
      textOption: TextFieldOption(
        //maxLength: 10,
        prefixWid: Text('+56',
            style:
                const TextStyle().normal16.textColor(ColorSchema.grey54Color)),
        inputController: myAccountController.myPhoneNumberController,
        keyboardType: TextInputType.number,
        labelText: AppLocalizations.of(context)!.phoneNumber,
        labelStyleText: myAccountController.isPhoneNumberValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      clearIcon: false,
      onNextPress: () {
        myAccountController.myDobFocusNode.requestFocus();
      },
      validation: (val) {
        if (val!.isNotEmpty) {
          myAccountController.isPhoneNumberValid.value = false;
          myAccountController.isPhoneNumberButtonValid.value = false;
          if (val.length != 9) {
            myAccountController.isPhoneNumberValid.value = false;
            myAccountController.isPhoneNumberButtonValid.value = false;
            return "";
          } else {
            myAccountController.isPhoneNumberValid.value = true;
            myAccountController.isPhoneNumberButtonValid.value = true;
            return null;
          }
        } else {
          myAccountController.isPhoneNumberValid.value = true;
          myAccountController.isPhoneNumberButtonValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isNotEmpty) {
          myAccountController.isPhoneNumberValid.value = false;
          myAccountController.isPhoneNumberButtonValid.value = false;
          if (val.length != 9) {
            myAccountController.isPhoneNumberValid.value = false;
            myAccountController.isPhoneNumberButtonValid.value = false;
          } else {
            myAccountController.isPhoneNumberValid.value = true;
            myAccountController.isPhoneNumberButtonValid.value = true;
          }
        } else {
          myAccountController.isPhoneNumberValid.value = true;
          myAccountController.isPhoneNumberButtonValid.value = true;
        }
        myAccountController.update();
      },
    );
  }

  TextFormField _birthDateTextField(BuildContext context) {
    return TextFormField(
      focusNode: myAccountController.myDobFocusNode,
      controller: myAccountController.myDobController,
      enabled: myAccountController.isEdit.value,
      decoration: InputDecoration(
        isDense: true,
        // contentPadding: EdgeInsets.symmetric(horizontal: getSize(10)),
        labelText: AppLocalizations.of(context)!.dob,
        labelStyle:
            const TextStyle().normal16.textColor(ColorSchema.grey54Color),
        // : const TextStyle().normal16.textColor(ColorSchema.redColor),
        errorStyle: const TextStyle(height: 0),
        border: InputBorder.none,
      ),
      onFieldSubmitted: (String text) {
        FocusScope.of(context).unfocus();
        myAccountController.myRutFocusNode.requestFocus();
      },
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        // Show Date Picker Here
        await _selectDate(context);
        myAccountController.myDobController.text =
            DateFormat('yyyy-MM-dd').format(myAccountController.selectedDate);
        // plusController.isDobValid.value = true;
        // plusController.isDobButtonValid.value = true;
        myAccountController.update();
      },
      validator: (val) {
        return null;

        // if (val!.isNotEmpty) {
        //   plusController.isDobValid.value = false;
        //   // plusController.isDobButtonValid.value = false;
        //   return "";
        // } else {
        //   plusController.isDobValid.value = true;
        //   // plusController.isDobButtonValid.value = true;
        //   return null;
        // }
      },
      onChanged: (val) {
        // if (val.isNotEmpty) {
        //   plusController.isDobValid.value = false;
        //   // plusController.isDobButtonValid.value = false;
        // } else {
        //   plusController.isDobValid.value = true;
        //   // plusController.isDobButtonValid.value = true;
        // }
        myAccountController.update();
      },
    );
  }

  CommonTextField _rutTextField(BuildContext context) {
    return CommonTextField(
      isEditable: myAccountController.isEdit.value,
      inputAction: TextInputAction.done,
      focusNode: myAccountController.myRutFocusNode,
      textOption: TextFieldOption(
        inputController: myAccountController.myRutController,
        keyboardType: TextInputType.visiblePassword,
        labelText: AppLocalizations.of(context)!.ruts,
        labelStyleText: myAccountController.isRutValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      clearIcon: false,
      validation: (val) {
        RUTValidator(
                validationErrorText: AppLocalizations.of(context)!.enterRut)
            .validator;
        if (val!.isNotEmpty) {
          myAccountController.isRutValid.value = false;
          // plusController.isRutButtonValid.value = false;
          if (!ValidationUtils.validateRut(val)) {
            myAccountController.isRutValid.value = true;
            // plusController.isRutButtonValid.value = true;
            return "";
          } else {
            myAccountController.isRutValid.value = true;
            // plusController.isRutButtonValid.value = true;
            return null;
          }
        }
      },
      textCallback: (val) {
        RUTValidator.formatFromTextController(
            myAccountController.myRutController);
        myAccountController.update();
        if (val.isNotEmpty) {
          myAccountController.isRutValid.value = false;
          // plusController.isRutButtonValid.value = false;
          if (!ValidationUtils.validateRut(val)) {
            myAccountController.isRutValid.value = true;
            // plusController.isRutButtonValid.value = true;
          } else {
            myAccountController.isRutValid.value = true;
            // plusController.isRutButtonValid.value = true;
          }
        }
        myAccountController.update();
      },
    );
  }

  //update button color.....
  Color buttonColor() {
    if (myAccountController.isNameButtonValid.value &&
        myAccountController.isLastNameButtonValid.value &&
        myAccountController.isPhoneNumberButtonValid.value &&
        myAccountController.isEmailButtonValid.value) {
      return ColorSchema.greenColor;
    } else {
      return ColorSchema.grey38Color;
    }
  }
}
