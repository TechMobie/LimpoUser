import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/routes/app_pages.dart';
import 'package:linpo_user/components/button/button.dart';
import 'package:linpo_user/components/common_container.dart';
import 'package:linpo_user/helper/utils/images.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ServiceAreaScreen extends StatelessWidget {
  const ServiceAreaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSchema.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getSize(15)),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: getSize(50),
              ),
              SvgPicture.asset(ImageConstants.entry, height: getSize(220)),
              const Spacer(),
              Text(
                AppLocalizations.of(context)!.weAreAvailableForYourArea,
                style: const TextStyle().medium16,
              ),
              const Spacer(),
              CommonAppButton(
                  text: AppLocalizations.of(context)!.guest,
                  onTap: () async {
                    Get.toNamed(Routes.bottomBarScreen);
                  },
                  width: double.infinity,
                  color: ColorSchema.greenColor,
                  style: const TextStyle()
                      .normal16
                      .textColor(ColorSchema.whiteColor),
                  borderRadius: 5),
              SizedBox(
                height: getSize(12),
              ),
              CommonAppButton(
                  text: AppLocalizations.of(context)!.signUp,
                  onTap: () async {
                    Get.toNamed(Routes.signUp);
                  },
                  width: double.infinity,
                  color: ColorSchema.primaryColor,
                  style: const TextStyle()
                      .normal16
                      .textColor(ColorSchema.whiteColor),
                  borderRadius: 5),
              SizedBox(
                height: getSize(18),
              )
            ],
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
    );
  }
}
