import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/modules/plans/choose_plan_controller.dart';
import 'package:linpo_user/app/modules/plans/our_plan_controller.dart';
import 'package:linpo_user/app/modules/plus/my_address/my_address_controller.dart';
import 'package:linpo_user/app/routes/app_pages.dart';
import 'package:linpo_user/components/button/button.dart';
import 'package:linpo_user/components/common_class.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/helper/utils/constants.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/helper/utils/pref_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChoosePlanScreen extends StatelessWidget {
  ChoosePlanScreen({
    Key? key,
  }) : super(key: key);

  final choosePlanController =
      Get.put<ChoosePlanController>(ChoosePlanController());
  // final myAddressController = Get.find<MyAddressController>();

  final int? ind = Get.arguments[1];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: ColorSchema.whiteColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getSize(15.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: getSize(20),
                ),
                CommonHeader(title: ""),
                SizedBox(
                  height: getSize(20),
                ),
                if ((choosePlanController.plansModel.data?.isPurchased ?? 0) >
                    0)
                  Text(
                    AppLocalizations.of(context)!.youCurrentlyAlready,
                    style: const TextStyle().medium16,
                  ),
                SizedBox(
                  height: getSize(20),
                ),
                GetBuilder<ChoosePlanController>(
                  init: choosePlanController,
                  builder: (controller) => choosePlanController
                          .showProgress.value
                      ? const Expanded(
                          child: Padding(
                          padding: EdgeInsets.only(bottom: 50),
                          child: Center(child: CircularProgressIndicator()),
                        ))
                      : isNullEmptyOrFalse(choosePlanController.plansModel.data)
                          ? Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom:
                                        MediaQuery.of(context).padding.bottom +
                                            90),
                                child: Center(
                                  child: Text(
                                    "No Plan Found",
                                    style: const TextStyle()
                                        .medium16
                                        .textColor(ColorSchema.blackColor),
                                  ),
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: getSize(10)),
                                itemCount: choosePlanController
                                        .plansModel.data?.planLits?.length ??
                                    0,
                                shrinkWrap: true,
                                itemBuilder: (context, index) => Container(
                                  padding: EdgeInsets.only(top: getSize(30)),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      border: Border.all(
                                          color: ColorSchema.grey38Color)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: getSize(30),
                                          right: getSize(30),
                                        ),
                                        child: Row(
                                          children: [
                                            SvgPicture.network(
                                              choosePlanController.plansModel
                                                  .data!.planLits![index].image
                                                  .toString(),
                                            ),
                                            SizedBox(
                                              width: getSize(10),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    choosePlanController
                                                        .plansModel
                                                        .data!
                                                        .planLits![index]
                                                        .name
                                                        .toString(),
                                                    style: const TextStyle()
                                                        .size(22)
                                                        .weight(FontWeight.w600)
                                                        .textColor(
                                                          ind! % 2 == 0
                                                              ? ColorSchema
                                                                  .primaryColor
                                                              : ColorSchema
                                                                  .greenColor,
                                                        ),
                                                  ),
                                                  SizedBox(
                                                    height: getSize(5),
                                                  ),
                                                  Text(
                                                    "${formatCurrency.format(choosePlanController.plansModel.data!.planLits![index].price)} / ${AppLocalizations.of(context)!.month}",
                                                    style: const TextStyle()
                                                        .medium19
                                                        .textColor(ColorSchema
                                                            .blackColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: getSize(20),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: getSize(25),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: getSize(30),
                                          right: getSize(30),
                                        ),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .monthlyServiceOf,
                                          style: const TextStyle()
                                              .normal18
                                              .textColor(
                                                  ColorSchema.blackColor),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: getSize(20),
                                          right: getSize(20),
                                        ),
                                        child: Html(
                                          data: choosePlanController
                                              .plansModel
                                              .data!
                                              .planLits![index]
                                              .monthlyServiceOf
                                              .toString(),
                                          style: {
                                            "p": Style(
                                              fontSize: FontSize.xLarge,
                                              letterSpacing: 0.0,
                                            )
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: getSize(20),
                                          right: getSize(20),
                                        ),
                                        child: Html(
                                          data: choosePlanController
                                              .plansModel
                                              .data!
                                              .planLits![index]
                                              .description
                                              .toString(),
                                          style: {
                                            "p": Style(
                                              fontSize: FontSize.medium,
                                              letterSpacing: 0.0,
                                            )
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: getSize(30),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: getSize(30),
                                          right: getSize(30),
                                        ),
                                        child: CommonButton(
                                          buttonColor: ind! % 2 == 0
                                              ? ColorSchema.primaryColor
                                              : ColorSchema.greenColor,
                                          height: getSize(40),
                                          width: double.infinity,
                                          boxShadow: const [
                                            BoxShadow(
                                              blurRadius: 2,
                                              color: ColorSchema.grey54Color,
                                              offset: Offset(2.0, 2.0),
                                            ),
                                          ],
                                          borderRadius: 5,
                                          text: AppLocalizations.of(context)!
                                              .contractPlan,
                                          textStyle: const TextStyle()
                                              .medium16
                                              .textColor(
                                                  ColorSchema.whiteColor),
                                          onTap: () {
                                            print(index);
                                            if (PrefUtils.getInstance
                                                .isUserLogin()) {
                                              if (choosePlanController
                                                      .plansModel
                                                      .data!
                                                      .isPurchased! >
                                                  0) {
                                                isPurchasedDialogueBox();
                                              } else {
                                                Get.toNamed(
                                                    Routes.contractPlanScreen,
                                                    arguments: [
                                                      choosePlanController
                                                          .plansModel
                                                          .data!
                                                          .planLits![index],
                                                      choosePlanController
                                                          .plansModel
                                                          .data!
                                                          .planLits![index]
                                                          .id
                                                          .toString(),
                                                    ]);
                                                // Navigator.push(
                                                //   Get.context!,
                                                //   MaterialPageRoute(
                                                //     builder: (context) =>
                                                //         ContractPlanScreen(
                                                //       typesOfPlansModel: plansController
                                                //           .plansModel
                                                //           .data!
                                                //           .planLits![index],
                                                //       typeOfPlanId: plansController
                                                //           .typesOfPlansModel.data![index].id
                                                //           .toString(),
                                                //     ),
                                                //   ),
                                                // );
                                              }
                                            } else {
                                              commonGuestDialogue(context);
                                            }
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: getSize(30),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                ),
                SizedBox(
                  height: getSize(15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  isPurchasedDialogueBox() {
    return showDialog(
        context: Get.context!,
        builder: (_) => Alertdialog(
            isFullButton: true,
            // titleWidget: Text(
            //   AppLocalizations.of(Get.context!)!.noAddressFound,
            //   style: const TextStyle().normal18,
            // ),
            contentText: AppLocalizations.of(Get.context!)!.youCurrentlyAlready,
            contentTextStyle:
                const TextStyle().normal16.textColor(ColorSchema.grey54Color),
            actionWidget: Text(
              AppLocalizations.of(Get.context!)!.closeCaps,
              style:
                  const TextStyle().medium16.textColor(ColorSchema.whiteColor),
            ),
            onTap: () {
              Get.back();
              //Get.back();
            }));
  }
}
