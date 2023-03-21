import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/modules/plans/our_plan_controller.dart';
import 'package:linpo_user/app/routes/app_pages.dart';
import 'package:linpo_user/components/common_class.dart';
import 'package:linpo_user/helper/utils/constants.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OurPlanScreen extends StatelessWidget {
  OurPlanScreen({Key? key}) : super(key: key);
  final plansController = Get.put<OurPlanController>(OurPlanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              CommonHeader(
                title: AppLocalizations.of(context)!.ourPlans,
              ),
              SizedBox(
                height: getSize(20),
              ),
              GetBuilder<OurPlanController>(
                init: plansController,
                builder: (controller) {
                  return plansController.showProgress.value
                      ? const Expanded(
                          child: Padding(
                          padding: EdgeInsets.only(bottom: 50),
                          child: Center(child: CircularProgressIndicator()),
                        ))
                      : Expanded(
                          child: ListView.separated(
                            itemCount: plansController
                                    .typesOfPlansModel.data?.length ??
                                0,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: getSize(15),
                              );
                            },
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: index % 2 == 0
                                        ? ColorSchema.extraLightBlueColor
                                        : ColorSchema.extraLightGreenColor,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black54,
                                          blurRadius: 0.0,
                                          offset: Offset(
                                            0.0,
                                            0.75,
                                          ))
                                    ]),
                                padding: EdgeInsets.symmetric(
                                    vertical: getSize(20),
                                    horizontal: getSize(15)),
                                width: MathUtilities.screenWidth(context),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      plansController
                                          .typesOfPlansModel.data![index].name
                                          .toString(),
                                      style: const TextStyle()
                                          .semibold24
                                          .weight(FontWeight.bold)
                                          .textColor(index % 2 == 0
                                              ? ColorSchema.primaryColor
                                              : ColorSchema.greenColor),
                                    ),
                                    SizedBox(
                                      height: getSize(15),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.from +
                                          formatCurrency.format(plansController
                                              .typesOfPlansModel
                                              .data![index]
                                              .fromPrice) +
                                          ' / ' +
                                          AppLocalizations.of(context)!.month,
                                      style: const TextStyle()
                                          .medium19
                                          .textColor(ColorSchema.blackColor),
                                    ),
                                    SizedBox(
                                      height: getSize(15),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.plans,
                                      style: const TextStyle()
                                          .medium19
                                          .textColor(ColorSchema.grey54Color),
                                    ),
                                    Html(
                                      data: plansController.typesOfPlansModel
                                          .data![index].description
                                          .toString(),
                                      style: {
                                        "p": Style(
                                            fontSize: FontSize.larger,
                                            color: ColorSchema.grey54Color,
                                            whiteSpace: WhiteSpace.pre,
                                            margin: Margins.symmetric(
                                                vertical: getSize(0))
                                            // lineHeight: LineHeight.percent(5)
                                            )
                                      },
                                    ),
                                    SizedBox(
                                      height: getSize(25),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: InkWell(
                                          onTap: () {
                                            Get.toNamed(Routes.choosePlanScreen,
                                                arguments: [
                                                  plansController
                                                      .typesOfPlansModel
                                                      .data![index]
                                                      .id,
                                                  index
                                                ]);
                                          },
                                          child: Container(
                                            width: getSize(220),
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 15,
                                                bottom: 15),
                                            decoration: BoxDecoration(
                                              color: index % 2 == 0
                                                  ? ColorSchema.primaryColor
                                                  : ColorSchema.greenColor,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Center(
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .chooseYourPlan,
                                                style: const TextStyle()
                                                    .medium19
                                                    .textColor(
                                                        ColorSchema.whiteColor),
                                              ),
                                            ),
                                          ),
                                        )),
                                        SizedBox(
                                          width: getSize(50),
                                        ),
                                        SvgPicture.network(
                                          plansController.typesOfPlansModel
                                              .data![index].image
                                              .toString(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                },
              ),
              SizedBox(
                height: getSize(20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
