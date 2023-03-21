// ignore_for_file: non_constant_identifier_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/data/controllers/global_controller.dart';
import 'package:linpo_user/app/data/models/profile/profile_model.dart';
import 'package:linpo_user/app/modules/bottomBar/bottom_bar_controller.dart';
import 'package:linpo_user/app/routes/app_pages.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/helper/utils/images.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/helper/utils/pref_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StartScreen extends StatelessWidget {
  final bottomBarController = Get.find<BottomBarController>();

  final globalController = Get.find<GlobalController>();

  StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: ColorSchema.whiteColor.withOpacity(0.1),
        body: Padding(
          padding: EdgeInsets.only(
              left: getSize(20), right: getSize(20), top: getSize(60)),
          child: Column(
            children: [
              SizedBox(
                height: getSize(10),
              ),
              Row(
                children: [
                  SizedBox(
                    width: getSize(10),
                  ),
                  GetBuilder<GlobalController>(
                    init: globalController,
                    builder: (controller) => Center(
                        child: Text(
                      "${AppLocalizations.of(context)!.hiClean} ${globalController.profileModel.data?.firstName! ?? ""}",
                      style: const TextStyle()
                          .bold20
                          .textColor(ColorSchema.blackColor),
                    )),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: getSize(36),
                    width: getSize(81),
                    child: SvgPicture.asset(
                      ImageConstants.appIcon,
                      color: ColorSchema.primaryColor,
                      //  color: ColorSchema.primaryColor,
                    ),
                  ),
                  SizedBox(
                    width: getSize(10),
                  ),
                ],
              ),
              SizedBox(
                height: getSize(15),
              ),
              Expanded(
                  child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(children: [
                        GetBuilder<GlobalController>(
                          init: globalController,
                          builder: (controller) => Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: [
                                Container(
                                  height: getSize(200),
                                  child: CarouselSlider.builder(
                                    itemCount: globalController.generalModel
                                            .data?.bannerImage?.length ??
                                        0,
                                    options: CarouselOptions(
                                      onPageChanged:
                                          (index, CarouselWithIndicator) {
                                        globalController.currentIndex = index;
                                        globalController.update();
                                      },
                                      viewportFraction: 1,
                                      initialPage: 0,
                                      enableInfiniteScroll: true,
                                      reverse: false,
                                      autoPlay: true,
                                      autoPlayInterval:
                                          const Duration(seconds: 3),
                                      autoPlayAnimationDuration:
                                          const Duration(milliseconds: 800),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      enlargeCenterPage: true,
                                      scrollDirection: Axis.horizontal,
                                      aspectRatio: 1.9,
                                    ),
                                    itemBuilder: (context, index, realIdx) {
                                      return Center(
                                        child: Image.network(
                                          globalController
                                                  .generalModel
                                                  .data
                                                  ?.bannerImage![index]
                                                  .bannerImage ??
                                              "",
                                          fit: BoxFit.fitHeight,
                                          // height: 200,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                  bottom: 15,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: (globalController.generalModel
                                                  .data?.bannerImage ??
                                              [])
                                          .map((image) {
                                        //these two lines
                                        int index = globalController
                                            .generalModel.data!.bannerImage!
                                            .indexOf(image); //are changed
                                        return Container(
                                          width: 8.0,
                                          height: 8.0,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 2.0),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: globalController
                                                          .currentIndex ==
                                                      index
                                                  ? ColorSchema.primaryColor
                                                  : ColorSchema.greyColor20),
                                        );
                                      }).toList()),
                                )
                              ]),
                        ),
                        SizedBox(
                          height: getSize(10),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _commonContainerBox(
                                onTap: () {
                                  bottomBarController.currentIndex.value = 1;
                                },
                                txt: AppLocalizations.of(context)!.newOrders,
                                txtColor: ColorSchema.whiteColor,
                                backgroundColor: ColorSchema.primaryColor,
                                img: ImageConstants.neworderImage),
                            SizedBox(
                              width: getSize(10),
                            ),
                            _commonContainerBox(
                                txt: AppLocalizations.of(context)!.myOrders,
                                onTap: () {
                                  if (PrefUtils.getInstance.isUserLogin()) {
                                    Get.toNamed(Routes.myOrder);
                                  } else {
                                    commonGuestDialogue(context);
                                  }
                                },
                                img: ImageConstants.myOrderImage),
                          ],
                        ),
                        SizedBox(
                          height: getSize(10),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                        
                             _commonContainerBox(
                                onTap: () {
                                  Get.toNamed(Routes.ourPlanScreen);
                                },
                                txt: AppLocalizations.of(context)!.ourPlans,
                                img: ImageConstants.how),
                            SizedBox(
                              width: getSize(10),
                            ),
                               _commonContainerBox(
                              onTap: () {
                                Get.toNamed(Routes.howDoesWorkScreen);
                              },
                              txt: AppLocalizations.of(context)!.howWork,
                              img: ImageConstants.plans,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getSize(10),
                        ),
                      ]))),
            ],
          ),
        ));
  }

  Expanded _commonContainerBox(
      {String? txt,
      Color? txtColor,
      Color? backgroundColor,
      Function? onTap,
      String? img}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onTap!();
        },
        child: Container(
          height: MathUtilities.screenWidth(Get.context!) / 2.1,
          width: MathUtilities.screenWidth(Get.context!) / 2,
          decoration: BoxDecoration(
              color: backgroundColor ?? ColorSchema.whiteColor,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SvgPicture.asset(
                  img!,
                  height: getSize(80),
                  // width: 100,
                ),
              ),
              SizedBox(
                height: getSize(4),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: getSize(10)),
                child: Text(
                  txt!,
                  style: const TextStyle()
                      .medium14
                      .textColor(txtColor ?? ColorSchema.blackColor),
                  textAlign: TextAlign.center,
                  //overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
