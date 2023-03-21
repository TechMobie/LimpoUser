import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/modules/bottomBar/bottom_bar_controller.dart';
import 'package:linpo_user/app/modules/services/services_controller.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/helper/utils/images.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AddServiceScreen extends StatelessWidget {
  AddServiceScreen({Key? key}) : super(key: key);

  final bottomBarController = Get.find<BottomBarController>();
  final servicesController = Get.find<ServicesController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        backgroundColor: ColorSchema.whiteColor,
        bottomNavigationBar: GestureDetector(
          onTap: () async {
            CustomDialogs.getInstance.showProgressDialog();

            await servicesController.getProductApiCall();
            bottomBarController.currentIndex.value = 1;
            CustomDialogs.getInstance.hideProgressDialog();
          },
          child: Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            margin:
                const EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
            decoration: BoxDecoration(
                color: ColorSchema.primaryColor,
                borderRadius: BorderRadius.circular(5)),
            width: double.infinity,
            child: Text(
              AppLocalizations.of(context)!.addServicesNow,
              style: const TextStyle().bold16.textColor(ColorSchema.whiteColor),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ImageConstants.neworderImage,
              height: getSize(130),
              width: getSize(140),
            ),
            SizedBox(height: getSize(120)),
            Center(
              child: SizedBox(
                height: getSize(41),
                width: getSize(240),
                child: Text(
                  AppLocalizations.of(context)!.yourMachineEmpty,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
