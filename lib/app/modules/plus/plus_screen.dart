import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/data/controllers/global_controller.dart';
import 'package:linpo_user/app/data/models/profile/profile_model.dart';
import 'package:linpo_user/app/modules/plus/plus_controller.dart';
import 'package:linpo_user/app/routes/app_pages.dart';
import 'package:linpo_user/components/button/button.dart';
import 'package:linpo_user/components/common_class.dart';
import 'package:linpo_user/components/common_list_tile.dart';
import 'package:linpo_user/helper/utils/constants.dart';
import 'package:linpo_user/helper/utils/enum.dart';
import 'package:linpo_user/helper/utils/images.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/helper/utils/pref_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlusScreen extends StatefulWidget {
  const PlusScreen({Key? key}) : super(key: key);

  @override
  State<PlusScreen> createState() => _PlusScreenState();
}

class _PlusScreenState extends State<PlusScreen> {
  final plusController = Get.put<PlusController>(PlusController());
  final globalController = Get.find<GlobalController>();
 

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      backgroundColor: ColorSchema.whiteColor,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: getSize(20), right: getSize(20), top: getSize(25)),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: getSize(10)),
                height: getSize(130),
                width: getSize(130),
                child: SvgPicture.asset(
                  ImageConstants.appIcon,
                  color: ColorSchema.primaryColor,
                ),
              ),
              GetBuilder<GlobalController>(
                init: globalController,
                builder: (controller) => Center(
                    child: Text(
                  "${AppLocalizations.of(context)!.hiClean} ${globalController.profileModel.data?.firstName}!",
                  style: const TextStyle()
                      .bold20
                      .textColor(ColorSchema.blackColor),
                )),
              ),
              SizedBox(
                height: getSize(40),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: ColorSchema.greyColor)),
                child: Column(
                  children: [
                    CommonListTile(
                        txt: AppLocalizations.of(context)!.myAccount,
                        image: SvgPicture.asset(
                          ImageConstants.account,
                          color: ColorSchema.primaryColor,
                        ),
                        padding: 4,
                        onTap: () {
                          Get.toNamed(Routes.myAccountScreen);
                        }),
                    const Divider(
                        color: ColorSchema.greyColor, thickness: 1, height: 0),
                    CommonListTile(
                        txt: AppLocalizations.of(context)!.changePassword,
                        image: SvgPicture.asset(
                          ImageConstants.lock,
                          height: 30,
                          width: 30,
                          color: ColorSchema.primaryColor,
                        ),
                        onTap: () {
                          Get.toNamed(Routes.changePassword);
                        }),
                    const Divider(
                        color: ColorSchema.greyColor, thickness: 1, height: 0),
                    CommonListTile(
                      txt: AppLocalizations.of(context)!.myAddress,
                      image: SvgPicture.asset(
                        ImageConstants.locationLogo,
                        height: 30,
                        width: 30,
                        color: ColorSchema.primaryColor,
                      ),
                      onTap: () {
                        Get.toNamed(Routes.myAddress,
                            arguments: EnumForAddressFillOrNot.myaddressScreen);
                      },
                    ),
                    const Divider(
                        color: ColorSchema.greyColor, thickness: 1, height: 0),
                    CommonListTile(
                        txt: AppLocalizations.of(context)!.meansOfPayment,
                        image: SvgPicture.asset(ImageConstants.creditcard,
                            color: ColorSchema.primaryColor),
                        padding: 2,
                        onTap: () {
                          Get.toNamed(Routes.paymentScreen,
                              arguments: EnumForPayment.myPaymentScreen);
                        }),
                    const Divider(
                        color: ColorSchema.greyColor, thickness: 1, height: 0),
                    CommonListTile(
                        txt: AppLocalizations.of(context)!.myOrders,
                        image: SvgPicture.asset(
                          ImageConstants.bill,
                          color: ColorSchema.primaryColor,
                        ),
                        padding: 9,
                        onTap: () {
                          Get.toNamed(Routes.myOrder);
                        }),
                    const Divider(
                        color: ColorSchema.greyColor, thickness: 1, height: 0),
                    CommonListTile(
                        txt: AppLocalizations.of(context)!.myPlan,
                        image: SvgPicture.asset(
                          ImageConstants.check,
                          height: 28,
                          width: 28,
                          color: ColorSchema.primaryColor,
                        ),
                        padding: 1,
                        onTap: () {
                          Get.toNamed(Routes.myPlan);
                        }),
                    const Divider(
                        color: ColorSchema.greyColor, thickness: 1, height: 0),
                    CommonListTile(
                        txt: AppLocalizations.of(context)!.contactUs,
                        image: SvgPicture.asset(
                          ImageConstants.mail,
                          color: ColorSchema.primaryColor,
                        ),
                        padding: 2,
                        onTap: () {
                          Get.toNamed(Routes.contactUs);
                        }),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              CommonAppButton(
                  text: AppLocalizations.of(context)!.signOff,
                  color: ColorSchema.primaryColor,
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (_) => Alertdialog(
                            isFullButton: false,
                            contentText: AppLocalizations.of(context)!
                                .areYouSureYouWantToLogout,
                            contentTextStyle: const TextStyle()
                                .medium19
                                .textColor(ColorSchema.grey54Color),
                            actionWidget: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text(AppLocalizations.of(context)!.no,
                                      style: const TextStyle().medium19),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    totalQuentity.value = 0;
                                    Get.offAllNamed(
                                      Routes.signIn,
                                    );
                                    plusController.logoutApiCall();
                                  },
                                  child: Text(AppLocalizations.of(context)!.yes,
                                      style: const TextStyle().medium19),
                                ),
                              ],
                            ),
                            onTap: () {}));
                  },
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
              const SizedBox(
                height: 10,
              ),
              CommonAppButton(
                  text: AppLocalizations.of(context)!.delete_acount,
                  color: ColorSchema.primaryColor,
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (_) => Alertdialog(
                            isFullButton: false,
                            contentText: AppLocalizations.of(context)!
                                .areYouSureYouWantToDeleteAccount,
                            contentTextStyle: const TextStyle()
                                .medium19
                                .textColor(ColorSchema.grey54Color),
                            actionWidget: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text(AppLocalizations.of(context)!.no,
                                      style: const TextStyle().medium19),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    totalQuentity.value = 0;
                                    Get.offAllNamed(
                                      Routes.signIn,
                                    );
                                    plusController.deleteAccountApiCall();
                                  },
                                  child: Text(AppLocalizations.of(context)!.yes,
                                      style: const TextStyle().medium19),
                                ),
                              ],
                            ),
                            onTap: () {}));
                  },
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
