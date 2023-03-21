import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linpo_user/helper/utils/images.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'my_washing_machine_controller.dart';

class Step4Screen extends StatelessWidget {
  Step4Screen({Key? key}) : super(key: key);

  final myWashingMachineController = Get.find<MyWashingMachineController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSchema.whiteColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    ImageConstants.finish,
                  ),
                  SizedBox(
                    height: getSize(10),
                  ),
                  Text(
                    AppLocalizations.of(context)!.thanks,
                    style: const TextStyle()
                        .bold16
                        .textColor(ColorSchema.blackColor),
                  ),
                  SizedBox(
                    height: getSize(10),
                  ),
                  Text(
                    AppLocalizations.of(context)!.yourPaymentSuccessfully,
                    style: const TextStyle()
                        .medium16
                        .textColor(ColorSchema.grey54Color),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: getSize(10),
                  ),
                  Text(
                    "${AppLocalizations.of(context)!.paymentMethod}: ${AppLocalizations.of(context)!.credit} ${myWashingMachineController.checkOutModel.data?.cardNumber.toString()}",
                    style: const TextStyle()
                        .medium14
                        .textColor(ColorSchema.grey54Color),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: getSize(10),
                  ),
                  Text(
                    "${AppLocalizations.of(context)!.yourOrderNo} ${myWashingMachineController.checkOutModel.data?.orderId.toString()} ${AppLocalizations.of(context)!.hasBeenGenerated}.",
                    style: const TextStyle()
                        .medium14
                        .textColor(ColorSchema.grey54Color),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getSize(10),
            ),
            Text(
              AppLocalizations.of(context)!.weWillSend,
              style:
                  const TextStyle().medium16.textColor(ColorSchema.grey54Color),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
