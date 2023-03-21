import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/data/models/services/product_services_model.dart';
import 'package:linpo_user/app/routes/app_pages.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({Key? key}) : super(key: key);
  Products products = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSchema.whiteColor,
      body: Padding(
        padding: EdgeInsets.only(
            left: getSize(16), right: getSize(16), top: getSize(60)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const CircleAvatar(
                    backgroundColor: ColorSchema.lightBlueColor,
                    radius: 15,
                    child: Icon(
                      Icons.close_rounded,
                      color: ColorSchema.whiteColor,
                      size: 20,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: getSize(20),
                      ),
                      height: getSize(70),
                      decoration: BoxDecoration(
                        color: ColorSchema.whiteColor,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: ColorSchema.greyColor30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: getSize(15),
                          ),
                          SvgPicture.network(products.image?.toString() ?? "",
                              height: 30, width: 30),
                          SizedBox(
                            width: getSize(10),
                          ),
                          Expanded(
                            child: Text(
                              products.name?.toString() ?? "",
                              style: const TextStyle()
                                  .medium16
                                  .textColor(ColorSchema.blackColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getSize(30),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          child: Text(
                            AppLocalizations.of(context)!
                                .moreInformationService,
                            style: const TextStyle()
                                .medium16
                                .textColor(ColorSchema.blackColor),
                          ),
                        ),
                        Container(
                          height: getSize(2),
                          width: getSize(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: ColorSchema.lightBlueColor),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: getSize(20)),
                      decoration: BoxDecoration(
                        color: ColorSchema.whiteColor,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: ColorSchema.greyColor30),
                      ),
                      padding: const EdgeInsets.all(15),
                      //height: getSize(170),
                      width: double.infinity,
                      child: Html(
                        data: products.description ?? "",
                        style: {
                          "body": Style(
                            padding: const EdgeInsets.all(0),
                            margin: Margins.all(0),
                            color: ColorSchema.greyColor1,
                            fontWeight: FontWeight.w500,
                          )
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.contactUs);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: getSize(10),
                            right: getSize(10),
                            top: getSize(10),
                            bottom: getSize(10)),
                        margin: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                            color: ColorSchema.primaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        // height: 60,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)!.ifYouQuestions,
                                style: const TextStyle()
                                    .medium16
                                    .textColor(ColorSchema.whiteColor),
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right,
                              color: ColorSchema.whiteColor,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
