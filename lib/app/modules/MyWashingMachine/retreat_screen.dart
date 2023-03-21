import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:linpo_user/app/modules/MyWashingMachine/retreat_controller.dart';
import 'package:linpo_user/components/button/button.dart';
import 'package:linpo_user/components/common_class.dart';
import 'package:linpo_user/helper/utils/constants.dart';
import 'package:linpo_user/helper/utils/enum.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RetreatScreen extends StatefulWidget {
  const RetreatScreen({Key? key}) : super(key: key);

  @override
  State<RetreatScreen> createState() => _RetreatScreenState();
}

class _RetreatScreenState extends State<RetreatScreen> {
  final retreatController = Get.put<RetreatController>(RetreatController());
  EnumForRetreat? enumForRetreat =
      Get.arguments[0] ?? EnumForRetreat.withdrawal;
  

  @override
  Widget build(BuildContext context) {
    // enumForRetreat = ;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: getSize(20),
                ),
                CommonHeader(
                    title: AppLocalizations.of(context)!.selectTheRetreat,
                    headerStyle: const TextStyle().medium14),
                SizedBox(
                  height: getSize(40),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DatePicker(
                      enumForRetreat == EnumForRetreat.withdrawal
                          ? DateTime.now().add(const Duration(days: 1))
                          : DateTime.now().weekday == 5
                              ? retreatController.pickUpSelectedDate.value
                                  .add(const Duration(days: 3))
                              : retreatController.pickUpSelectedDate.value
                                  .add(const Duration(days: 2)),
                      height: 93,
                      initialSelectedDate:
                          enumForRetreat == EnumForRetreat.withdrawal
                              ? retreatController.pickUpSelectedDate.value
                              : retreatController.deliverySelectedDate.value,
                      selectionColor: ColorSchema.babyBlueColor,
                      selectedTextColor: ColorSchema.primaryColor,
                      deactivatedColor: ColorSchema.babyBlueColor,
                      locale: myLocale.toString(),
                      inactiveDates: [
                        for (int i = 0; i <= 1000; i += 7)
                          DateTime.now().subtract(
                              Duration(days: DateTime.now().weekday - i)),
                      ],
                      onDateChange: (date) {
                        retreatController.selectedRetreatDate.value = date;

                        retreatController.update();
                        print(DateFormat('EEEE').format(
                            retreatController.selectedRetreatDate.value));
                      },
                    ),
                    SizedBox(
                      height: getSize(15),
                    ),
                    GetBuilder<RetreatController>(
                      init: retreatController,
                      builder: (controller) {
                        return (DateFormat('EEEE').format(retreatController
                                        .selectedRetreatDate.value) ==
                                    'Saturday' ||
                                DateFormat('EEEE').format(retreatController
                                        .selectedRetreatDate.value) ==
                                    'sábado')
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: getSize(15),
                                ),
                                height: getSize(55),
                                width: MathUtilities.screenWidth(context),
                                color: ColorSchema.babyBlueColor,
                                child: Row(
                                  children: [
                                    Text(
                                      enumForRetreat ==
                                              EnumForRetreat.withdrawal
                                          ? retreatController.pickUpList[0]
                                          : retreatController.deliveryList[0],
                                      style: const TextStyle()
                                          .normal16
                                          .textColor(retreatController
                                                      .selectIndex.value ==
                                                  0
                                              ? ColorSchema.primaryColor
                                              : ColorSchema.blackColor),
                                    ),
                                    const Spacer(),
                                    Icon(
                                      Icons.check,
                                      color: ColorSchema.greenColor,
                                      size: getSize(20),
                                    ),
                                    SizedBox(
                                      width: getSize(25),
                                    ),
                                    Text(
                                        AppLocalizations.of(context)!.available,
                                        style: const TextStyle()
                                            .normal16
                                            .textColor(
                                                ColorSchema.primaryColor))
                                  ],
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    enumForRetreat == EnumForRetreat.withdrawal
                                        ? retreatController.pickUpList.length
                                        : retreatController.deliveryList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        retreatController.selectIndex.value =
                                            index;
                                        retreatController.update();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: getSize(15),
                                        ),
                                        height: getSize(55),
                                        width:
                                            MathUtilities.screenWidth(context),
                                        color: retreatController
                                                    .selectIndex.value ==
                                                index
                                            ? ColorSchema.babyBlueColor
                                            : ColorSchema.greyColor,
                                        child: Row(
                                          children: [
                                            Text(
                                              enumForRetreat ==
                                                      EnumForRetreat.withdrawal
                                                  ? retreatController
                                                      .pickUpList[index]
                                                  : retreatController
                                                      .deliveryList[index],
                                              style: const TextStyle()
                                                  .normal16
                                                  .textColor(retreatController
                                                              .selectIndex
                                                              .value ==
                                                          index
                                                      ? ColorSchema.primaryColor
                                                      : ColorSchema.blackColor),
                                            ),
                                            const Spacer(),
                                            retreatController
                                                        .selectIndex.value ==
                                                    index
                                                ? Icon(
                                                    Icons.check,
                                                    color:
                                                        ColorSchema.greenColor,
                                                    size: getSize(20),
                                                  )
                                                : Container(),
                                            SizedBox(
                                              width: getSize(25),
                                            ),
                                            Text(
                                                AppLocalizations.of(context)!
                                                    .available,
                                                style: const TextStyle()
                                                    .normal16
                                                    .textColor(retreatController
                                                                .selectIndex
                                                                .value ==
                                                            index
                                                        ? ColorSchema
                                                            .primaryColor
                                                        : ColorSchema
                                                            .blackColor))
                                          ],
                                        ),
                                      ));
                                });
                      },
                    ),
                    SizedBox(
                      height: getSize(15),
                    ),
                    CommonAppButton(
                        text: enumForRetreat == EnumForRetreat.withdrawal
                            ? AppLocalizations.of(context)!.confirmWithdrawal
                            : AppLocalizations.of(context)!.confirmDispatch,
                        onTap: () {
                          if (DateFormat('EEEE').format(retreatController
                                      .selectedRetreatDate.value) ==
                                  'Saturday' ||
                              DateFormat('EEEE').format(retreatController
                                      .selectedRetreatDate.value) ==
                                  'sábado') {
                            retreatController.selectIndex.value = 0;
                          }
                          if (enumForRetreat == EnumForRetreat.withdrawal) {
                            retreatController.selectTimeForPickUp.value =
                                retreatController.pickUpList[
                                    retreatController.selectIndex.value];
                            retreatController.selectTimeForDelivery.value =
                                retreatController.selectTimeForPickUp.value;
                            retreatController.pickUpSelectedDate.value =
                                retreatController.selectedRetreatDate.value;
                            retreatController.setDeliveryDate();
                          } else {
                            retreatController.selectTimeForDelivery.value =
                                retreatController.deliveryList[
                                    retreatController.selectIndex.value];
                            retreatController.deliverySelectedDate.value =
                                retreatController.selectedRetreatDate.value;
                          }
                          retreatController.selectIndex.value = 0;

                          retreatController.update();
                          Get.back();
                        },
                        width: double.infinity,
                        color: ColorSchema.primaryColor,
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
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
