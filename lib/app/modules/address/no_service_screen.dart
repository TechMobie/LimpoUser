import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/modules/address/no_service_controller.dart';
import 'package:linpo_user/components/button/button.dart';
import 'package:linpo_user/components/common_container.dart';
import 'package:linpo_user/components/common_text_field.dart';
import 'package:linpo_user/helper/utils/images.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/helper/utils/string_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoServiceScreen extends StatefulWidget {
  const NoServiceScreen({Key? key}) : super(key: key);

  @override
  State<NoServiceScreen> createState() => _NoServiceScreenState();
}

class _NoServiceScreenState extends State<NoServiceScreen> {
  final noServiceController = Get.put<NoServiceController>(NoServiceController());
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    noServiceController.emailController.clear();
    noServiceController.isEmailValid.value = true;
    noServiceController.isEmailButtonValid.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: GetBuilder<NoServiceController>(
        init: noServiceController,
        builder: (controller) => Scaffold(
          backgroundColor: ColorSchema.whiteColor,
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: getSize(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: getSize(50),
                        ),
                        SvgPicture.asset(
                          ImageConstants.noService,
                          width: 170,
                          height: 170,
                        ),
                        SizedBox(
                          height: getSize(90),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: getSize(30)),
                          child: Text(
                            AppLocalizations.of(context)!.sorryWeHaveNotReached,
                            style: const TextStyle().normal16,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: getSize(30),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: getSize(30)),
                          child: Text(
                            AppLocalizations.of(context)!.leaveUsYourEmail,
                            style: const TextStyle().normal16,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: getSize(40),
                        ),
                        TextfieldContainer(widget: _emailTextField(context)),
                        SizedBox(
                          height: getSize(15),
                        ),
                        CommonAppButton(
                            text: AppLocalizations.of(context)!.toSend,
                            onTap: () async {
                                FocusScope.of(context).unfocus();
                               
                             
                              if (formKey.currentState!.validate()) {
                           noServiceController.coverageRequestApiCall();
                              } else {
                                noServiceController.isEmailValid.value = false;
                                noServiceController.update();
              
                              }
                             
                            },
                            width: double.infinity,
                            color: noServiceController.isEmailButtonValid.value
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
                // addressController.directionController.clear();
                // addressController.isClearIcon.value = false;
                noServiceController.update();
              },
            ),
          ),
        ),
      ),
    );
  }

  CommonTextField _emailTextField(BuildContext context) {
    return CommonTextField(
      inputAction: TextInputAction.done,
      focusNode: noServiceController.emailFocusNode,
      textOption: TextFieldOption(
        inputController: noServiceController.emailController,
        keyboardType: TextInputType.emailAddress,
        labelText: AppLocalizations.of(context)!.email,
        labelStyleText: noServiceController.isEmailValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      clearIcon:
          noServiceController.emailController.text.isNotEmpty ? true : false,
      function: () {
        noServiceController.emailController.clear();
        noServiceController.isEmailValid.value = false;
        noServiceController.isEmailButtonValid.value = false;
        noServiceController.update();
      },
      validation: (val) {
        if (val!.isEmpty) {
          noServiceController.isEmailValid.value = false;
          noServiceController.isEmailButtonValid.value = false;
          return "";
        } else if (!ValidationUtils.validateEmail(val)) {
          noServiceController.isEmailValid.value = false;
          noServiceController.isEmailButtonValid.value = false;
          return "";
        } else {
          noServiceController.isEmailValid.value = true;
          noServiceController.isEmailButtonValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          noServiceController.isEmailValid.value = false;
          noServiceController.isEmailButtonValid.value = false;
        } else if (!ValidationUtils.validateEmail(val)) {
          noServiceController.isEmailValid.value = false;
          noServiceController.isEmailButtonValid.value = false;
        } else {
          noServiceController.isEmailValid.value = true;
          noServiceController.isEmailButtonValid.value = true;
        }
        noServiceController.update();
      },
    );
  }
}
