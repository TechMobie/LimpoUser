import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/data/controllers/global_controller.dart';
import 'package:linpo_user/app/data/models/generalModel/general_model.dart';
import 'package:linpo_user/components/common_class.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/helper/utils/pref_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linpo_user/schemata/color_schema.dart';

class TermsCondition extends StatelessWidget {
  TermsCondition({Key? key}) : super(key: key);
  final GlobalController globalController =
      Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    globalController.generalModel =
        GeneralModel.fromJson(PrefUtils.getInstance.readData(
      PrefUtils.getInstance.generalSetting,
    ));
    return Scaffold(
      backgroundColor: ColorSchema.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getSize(15.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: getSize(25),
                ),
                CommonHeader(
                  title: AppLocalizations.of(context)!.termsAndCondition,
                ),
                SizedBox(
                  height: getSize(15),
                ),
                Html(
                  data: globalController
                      .generalModel.data?.page?[0].pageDescription
                      .toString(),
                  style: {
                    "p": Style(
                      fontSize: FontSize.xLarge,
                      letterSpacing: 0.0,
                    )
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
