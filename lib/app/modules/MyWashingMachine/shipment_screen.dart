import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/modules/MyWashingMachine/my_washing_machine_controller.dart';
import 'package:linpo_user/components/common_class.dart';
import 'package:linpo_user/helper/utils/constants.dart';
import 'package:linpo_user/helper/utils/images.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShipmentScreen extends StatelessWidget {
  ShipmentScreen({Key? key}) : super(key: key);
  final myWashingMachineController = Get.find<MyWashingMachineController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              CommonHeader(
                title: "",
                onTap: () {
                  Get.back();
                },
              ),
              const SizedBox(
                height: 50,
              ),
              SvgPicture.asset(
                ImageConstants.deliverytTruck,
                height: 150,
              ),
              const SizedBox(
                height: 30,
              ),
              GetBuilder<MyWashingMachineController>(
                init: myWashingMachineController,
                builder: (controller) => Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    "${AppLocalizations.of(context)!.forPurchaseOver} ${formatCurrency.format(myWashingMachineController.generalModel.data?.generalSetting?.minimumOrderAmountForFreeShipping)} ${AppLocalizations.of(context)!.shippingIsFree}",
                    style: const TextStyle()
                        .medium19
                        .textColor(ColorSchema.blackColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
