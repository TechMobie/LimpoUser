import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linpo_user/components/common_class.dart';
import 'package:linpo_user/helper/utils/commonDotIndicator.dart';
import 'package:linpo_user/helper/utils/images.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';

class HowDoesWorkScreen extends StatefulWidget {
  const HowDoesWorkScreen({Key? key}) : super(key: key);

  @override
  State<HowDoesWorkScreen> createState() => _HowDoesWorkScreenState();
}

class _HowDoesWorkScreenState extends State<HowDoesWorkScreen> {
  List<CustomModel> pages = [
    CustomModel(
        title: AppLocalizations.of(Get.context!)!.youPlaceOrder,
        subtitle: AppLocalizations.of(Get.context!)!.youPlaceOrderSubTitle,
        image: ImageConstants.how1),
    CustomModel(
        title: AppLocalizations.of(Get.context!)!.withdraw,
        subtitle: AppLocalizations.of(Get.context!)!.withdrawSubTitle,
        image: ImageConstants.how2),
    CustomModel(
        title: AppLocalizations.of(Get.context!)!.careAndWash,
        subtitle: AppLocalizations.of(Get.context!)!.careAndWashSubTitle,
        image: ImageConstants.how3),
    CustomModel(
        title: AppLocalizations.of(Get.context!)!.tackItToYourHouse,
        subtitle: AppLocalizations.of(Get.context!)!.tackItToYourHouseSubTitle,
        image: ImageConstants.how4),
  ];
  double currentPage = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSchema.whiteColor,
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: getSize(15),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getSize(15)),
                child: CommonHeader(
                  title: "",
                ),
              ),
              Text(
                AppLocalizations.of(Get.context!)!.howDoesWork,
                style: const TextStyle()
                    .medium19
                    .textColor(ColorSchema.primaryColor),
              ),
              Expanded(
                child: PageView.builder(
                  onPageChanged: (val) {
                    currentPage = val.toDouble();
                    setState(() {});
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        Expanded(
                          child: SvgPicture.asset(
                            pages[index].image!,
                            height: 160,
                            width: 160,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            pages[index].title!,
                            textAlign: TextAlign.center,
                            style: const TextStyle()
                                .medium20
                                .textColor(ColorSchema.blackColor),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Text(pages[index].subtitle!,
                              textAlign: TextAlign.center,
                              style: const TextStyle()
                                  .normal16
                                  .textColor(ColorSchema.blackColor)),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    );
                  },
                  itemCount: pages.length,
                ),
              ),
              CommonDotIndicator(
                totalPages: 4,
                currentPage: currentPage,
              ),
              if (currentPage != 3)
                const SizedBox(
                  height: 170,
                ),
              if (currentPage == 3)
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.only(bottom: 100, top: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: ColorSchema.primaryColor,
                    ),
                    child: Center(
                        child: Text(
                      AppLocalizations.of(context)!.close,
                      style: const TextStyle()
                          .medium16
                          .textColor(ColorSchema.whiteColor),
                    )),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomModel {
  String? image;
  String? title;
  String? subtitle;

  CustomModel({this.image, this.subtitle, this.title});
}
