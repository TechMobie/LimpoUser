import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/modules/plans/contract_plan/contract_plan_controller.dart';
import 'package:linpo_user/components/button/button.dart';
import 'package:linpo_user/helper/utils/images.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SuccessfulScreen extends StatelessWidget {
  SuccessfulScreen({Key? key}) : super(key: key);

  final contractPlanController = Get.find<ContractPlanController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSchema.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                ImageConstants.finish,
              ),
              SizedBox(
                height: getSize(30),
              ),
              Text(
                AppLocalizations.of(context)!.thanks,
                style: const TextStyle()
                    .bold16
                    .textColor(ColorSchema.blackColor),
              ),
              SizedBox(
                height: getSize(20),
              ),
              Text(
                AppLocalizations.of(context)!.yourSubscriptionSuccessful,
                style: const TextStyle()
                    .medium16
                    .textColor(ColorSchema.grey54Color),
              ),
              SizedBox(
                height: getSize(20),
              ),
              Text(
                "${AppLocalizations.of(context)!.paymentMethod}: ${AppLocalizations.of(context)!.credit} ${contractPlanController.checkOutPlanModel.data!.cardNumber.toString()}",
                style: const TextStyle()
                    .medium14
                    .textColor(ColorSchema.grey54Color),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: getSize(20
                ),
              ),
              Flexible(
                child: Text(
                  AppLocalizations.of(context)!.weWillSend,
                  style: const TextStyle()
                      .medium14
                      .textColor(ColorSchema.grey54Color),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: getSize(30),
              ),
              CommonAppButton(
                  text: AppLocalizations.of(context)!.backToTop,
                  onTap: ()  {
                    Get.back();
                    Get.back();
                    Get.back();
                    Get.back();
                  },
                  color: ColorSchema.primaryColor,
                  width: double.infinity,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 2,
                      color: ColorSchema.grey54Color,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                  style: const TextStyle()
                      .medium16
                      .textColor(ColorSchema.whiteColor),
                  borderRadius: 5),
            ],
          ),
        ),
      ),
    );
  }
}
