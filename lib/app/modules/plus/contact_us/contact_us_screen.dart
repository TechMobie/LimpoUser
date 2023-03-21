import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/modules/plus/contact_us/contac_us_controller.dart';
import 'package:linpo_user/components/button/button.dart';
import 'package:linpo_user/components/common_class.dart';
import 'package:linpo_user/components/common_container.dart';
import 'package:linpo_user/components/common_text_field.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final formKey = GlobalKey<FormState>();
  final contactUsController =
      Get.put<ContactUsController>(ContactUsController());

  @override
  Widget build(BuildContext context) {
    List<String> cityList = [
      AppLocalizations.of(context)!.coverages,
      AppLocalizations.of(context)!.others,
      AppLocalizations.of(context)!.claim,
      AppLocalizations.of(context)!.services
    ];
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: GetBuilder<ContactUsController>(
                  init: contactUsController,
                  builder: (controller) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: getSize(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: getSize(20),
                        ),
                        CommonHeader(
                          title: AppLocalizations.of(context)!.contactUs,
                        ),
                        SizedBox(
                          height: getSize(30),
                        ),
                        Text(AppLocalizations.of(context)!.contact,
                            style: const TextStyle()
                                .normal16
                                .textColor(ColorSchema.grey54Color)),
                        SizedBox(
                          height: getSize(15),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: getSize(0), horizontal: getSize(20)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  width: 1, color: ColorSchema.grey54Color)),
                          child: DropdownButtonFormField(
                            isDense: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              hintText: AppLocalizations.of(context)!.category,
                              errorStyle: const TextStyle()
                                  .errorText12
                                  .textColor(ColorSchema.redColor),
                            ),
                            onChanged: (String? val) {
                              if (val!.isEmpty) {
                                contactUsController.isCategoryValid.value =
                                    false;
                                contactUsController.dropDownValue!.value = val;
                              } else {
                                contactUsController.isCategoryValid.value =
                                    true;
                                contactUsController.dropDownValue!.value = val;
                              }
                            },
                            validator: (String? val) {
                              return null;
                            },
                            items: cityList
                                .map((cityTitle) => DropdownMenuItem(
                                    value: cityTitle, child: Text(cityTitle)))
                                .toList(),
                          ),
                        ),
                        SizedBox(
                          height: getSize(10),
                        ),
                        TextfieldContainer(
                            height: 120, widget: _addCommentTextField(context)),
                        SizedBox(
                          height: getSize(20),
                        ),
                        CommonAppButton(
                            text: AppLocalizations.of(context)!
                                .sendComment, //AppLocalizations.of(context)!.logInText,
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              if (formKey.currentState!.validate()) {
                                if (kDebugMode) {
                                  print("Send comment");
                                }
                                await contactUsController
                                    .contactUsApiCall(context);
                              }
                            },
                            width: double.infinity,
                            color: contactUsController.isCategoryValid.value &&
                                    contactUsController
                                        .isCommentButtonValid.value
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
        ));
  }

  CommonTextField _addCommentTextField(BuildContext context) {
    return CommonTextField(
      focusNode: contactUsController.addCommentsFocusNode,
      inputAction: TextInputAction.done,
      textOption: TextFieldOption(
        inputController: contactUsController.addCommentsController,
        keyboardType: TextInputType.name,
        minLine: 4,
        maxLine: 5,
        labelText: AppLocalizations.of(context)!.addComments,
        labelStyleText: contactUsController.isCommentValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      clearIcon: false,
      contentPadding:
          EdgeInsets.symmetric(horizontal: getSize(10), vertical: getSize(10)),
      validation: (val) {
        if (val!.isEmpty) {
          contactUsController.isCommentValid.value = false;
          contactUsController.isCommentButtonValid.value = false;
          return "";
        } else {
          contactUsController.isCommentValid.value = true;
          contactUsController.isCommentButtonValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          contactUsController.isCommentValid.value = false;
          contactUsController.isCommentButtonValid.value = false;
        } else {
          contactUsController.isCommentValid.value = true;
          contactUsController.isCommentButtonValid.value = true;
        }
        contactUsController.update();
      },
    );
  }
}
