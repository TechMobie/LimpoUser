// ignore_for_file: use_function_type_syntax_for_parameters

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:linpo_user/app/modules/plans/contract_plan/contract_plan_controller.dart';
import 'package:linpo_user/components/button/button.dart';
import 'package:linpo_user/components/common_class.dart';
import 'package:linpo_user/helper/utils/constants.dart';
import 'package:linpo_user/helper/utils/enum.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class RetreatPlan extends StatefulWidget {
  const RetreatPlan({Key? key}) : super(key: key);

  @override
  State<RetreatPlan> createState() => _RetreatPlanState();
}

class _RetreatPlanState extends State<RetreatPlan> {
  final contractPlanController = Get.find<ContractPlanController>();
  EnumForPlanRetreat? enumForPlanRetreat =
      Get.arguments[0] ?? EnumForPlanRetreat.withdrawal1;
  @override
  void initState() {
    enumForPlanRetreat == EnumForPlanRetreat.withdrawal1
        ? contractPlanController.selectedRetreatDate.value =
            contractPlanController.selectedDate1.value
        : enumForPlanRetreat == EnumForPlanRetreat.withdrawal2
            ? contractPlanController.selectedRetreatDate.value =
                contractPlanController.selectedDate2.value
            : enumForPlanRetreat == EnumForPlanRetreat.withdrawal3
                ? contractPlanController.selectedRetreatDate.value =
                    contractPlanController.selectedDate3.value
                : contractPlanController.selectedRetreatDate.value =
                    contractPlanController.selectedDate4.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      enumForPlanRetreat == EnumForPlanRetreat.withdrawal1
                          ? DateTime.now().add(const Duration(days: 1))
                          : enumForPlanRetreat == EnumForPlanRetreat.withdrawal2
                              ? contractPlanController.selectedDate2_2.value
                              : enumForPlanRetreat ==
                                      EnumForPlanRetreat.withdrawal3
                                  ? contractPlanController.selectedDate3_3.value
                                  : contractPlanController
                                      .selectedDate4_4.value,
                      height: 93,
                      initialSelectedDate: enumForPlanRetreat ==
                              EnumForPlanRetreat.withdrawal1
                          ? contractPlanController.selectedDate1.value
                          : enumForPlanRetreat == EnumForPlanRetreat.withdrawal2
                              ? contractPlanController.selectedDate2.value
                              : enumForPlanRetreat ==
                                      EnumForPlanRetreat.withdrawal3
                                  ? contractPlanController.selectedDate3.value
                                  : contractPlanController.selectedDate4.value,
                      selectionColor: ColorSchema.babyBlueColor,
                      selectedTextColor: ColorSchema.primaryColor,
                      deactivatedColor: ColorSchema.babyBlueColor,
                      locale: myLocale.toString(),
                      activeDates: [
                        enumForPlanRetreat == EnumForPlanRetreat.withdrawal1
                            ? contractPlanController.selectedDate1_1.value
                            : enumForPlanRetreat ==
                                    EnumForPlanRetreat.withdrawal2
                                ? contractPlanController.selectedDate2_2.value
                                : enumForPlanRetreat ==
                                        EnumForPlanRetreat.withdrawal3
                                    ? contractPlanController
                                        .selectedDate3_3.value
                                    : contractPlanController
                                        .selectedDate4_4.value,
                        for (int i = 1; i <= 5; i++)
                          enumForPlanRetreat == EnumForPlanRetreat.withdrawal1
                              ? contractPlanController.selectedDate1_1.value
                                  .add(Duration(days: i))
                              : enumForPlanRetreat ==
                                      EnumForPlanRetreat.withdrawal2
                                  ? contractPlanController.selectedDate2_2.value
                                      .add(Duration(days: i))
                                  : enumForPlanRetreat ==
                                          EnumForPlanRetreat.withdrawal3
                                      ? contractPlanController
                                          .selectedDate3_3.value
                                          .add(Duration(days: i))
                                      : contractPlanController
                                          .selectedDate4_4.value
                                          .add(Duration(days: i)),
                      ],
                      onDateChange: (date) {
                        contractPlanController.selectedRetreatDate.value = date;

                        // contractPlanController.update(["retreatPlanScreen"]);
                        // plansController.update();
                        // plansController.update(["retreatPlanScreen"]);
                        contractPlanController.update();
                      },
                    ),
                    SizedBox(
                      height: getSize(15),
                    ),
                    GetBuilder(
                      // id: "retreatPlanScreen",
                      init: ContractPlanController(),
                      builder: (controller) {
                        return (DateFormat('EEEE').format(contractPlanController
                                        .selectedRetreatDate.value) ==
                                    'Saturday' ||
                                DateFormat('EEEE').format(contractPlanController
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
                                      enumForPlanRetreat ==
                                              EnumForPlanRetreat.withdrawal1
                                          ? contractPlanController.timeList1[0]
                                          : enumForPlanRetreat ==
                                                  EnumForPlanRetreat.withdrawal2
                                              ? contractPlanController
                                                  .timeList2[0]
                                              : enumForPlanRetreat ==
                                                      EnumForPlanRetreat
                                                          .withdrawal3
                                                  ? contractPlanController
                                                      .timeList3[0]
                                                  : contractPlanController
                                                      .timeList4[0],
                                      style: const TextStyle()
                                          .normal16
                                          .textColor(contractPlanController
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
                                itemCount: enumForPlanRetreat ==
                                        EnumForPlanRetreat.withdrawal1
                                    ? contractPlanController.timeList1.length
                                    : enumForPlanRetreat ==
                                            EnumForPlanRetreat.withdrawal2
                                        ? contractPlanController
                                            .timeList2.length
                                        : enumForPlanRetreat ==
                                                EnumForPlanRetreat.withdrawal3
                                            ? contractPlanController
                                                .timeList3.length
                                            : contractPlanController
                                                .timeList4.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      contractPlanController.selectIndex.value =
                                          index;
                                      contractPlanController.update();
                                      // contractPlanController
                                      //     .update(["retreatPlanScreen"]);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: getSize(15),
                                      ),
                                      height: getSize(55),
                                      width: MathUtilities.screenWidth(context),
                                      color: contractPlanController
                                                  .selectIndex.value ==
                                              index
                                          ? ColorSchema.babyBlueColor
                                          : ColorSchema.greyColor,
                                      child: Row(
                                        children: [
                                          Text(
                                            enumForPlanRetreat ==
                                                    EnumForPlanRetreat
                                                        .withdrawal1
                                                ? contractPlanController
                                                    .timeList1[index]
                                                : enumForPlanRetreat ==
                                                        EnumForPlanRetreat
                                                            .withdrawal2
                                                    ? contractPlanController
                                                        .timeList2[index]
                                                    : enumForPlanRetreat ==
                                                            EnumForPlanRetreat
                                                                .withdrawal3
                                                        ? contractPlanController
                                                            .timeList3[index]
                                                        : contractPlanController
                                                            .timeList4[index],
                                            style: const TextStyle()
                                                .normal16
                                                .textColor(
                                                    contractPlanController
                                                                .selectIndex
                                                                .value ==
                                                            index
                                                        ? ColorSchema
                                                            .primaryColor
                                                        : ColorSchema
                                                            .blackColor),
                                          ),
                                          const Spacer(),
                                          contractPlanController
                                                      .selectIndex.value ==
                                                  index
                                              ? Icon(
                                                  Icons.check,
                                                  color: ColorSchema.greenColor,
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
                                                  .textColor(
                                                      contractPlanController
                                                                  .selectIndex
                                                                  .value ==
                                                              index
                                                          ? ColorSchema
                                                              .primaryColor
                                                          : ColorSchema
                                                              .blackColor))
                                        ],
                                      ),
                                    ),
                                  );
                                });
                      },
                    ),
                    SizedBox(
                      height: getSize(15),
                    ),
                    CommonAppButton(
                        text: enumForPlanRetreat ==
                                EnumForPlanRetreat.withdrawal1
                            ? "${AppLocalizations.of(context)!.confirmWithdrawal} 1"
                            : enumForPlanRetreat ==
                                    EnumForPlanRetreat.withdrawal2
                                ? "${AppLocalizations.of(context)!.confirmWithdrawal} 2"
                                : enumForPlanRetreat ==
                                        EnumForPlanRetreat.withdrawal3
                                    ? "${AppLocalizations.of(context)!.confirmWithdrawal} 3"
                                    : "${AppLocalizations.of(context)!.confirmDispatch} 4",
                        onTap: () {
                          if (DateFormat('EEEE').format(contractPlanController
                                      .selectedRetreatDate.value) ==
                                  'Saturday' ||
                              DateFormat('EEEE').format(contractPlanController
                                      .selectedRetreatDate.value) ==
                                  'sábado') {
                            contractPlanController.selectIndex.value = 0;
                          }
                          if (enumForPlanRetreat ==
                              EnumForPlanRetreat.withdrawal1) {
                            contractPlanController.selectedTime1.value =
                                contractPlanController.timeList1[
                                    contractPlanController.selectIndex.value];

                            contractPlanController.selectedDate1.value =
                                contractPlanController
                                    .selectedRetreatDate.value;
                            contractPlanController.selectedTime2.value =
                                contractPlanController.selectedTime1.value;
                            contractPlanController.selectedTime3.value =
                                contractPlanController.selectedTime1.value;
                            contractPlanController.selectedTime4.value =
                                contractPlanController.selectedTime1.value;
                            contractPlanController.setDate2();
                          } else if (enumForPlanRetreat ==
                              EnumForPlanRetreat.withdrawal2) {
                            contractPlanController.selectedTime2.value =
                                contractPlanController.timeList2[
                                    contractPlanController.selectIndex.value];

                            contractPlanController.selectedDate2.value =
                                contractPlanController
                                    .selectedRetreatDate.value;
                            contractPlanController.setDate3();
                          } else if (enumForPlanRetreat ==
                              EnumForPlanRetreat.withdrawal3) {
                            contractPlanController.selectedTime3.value =
                                contractPlanController.timeList3[
                                    contractPlanController.selectIndex.value];

                            contractPlanController.selectedDate3.value =
                                contractPlanController
                                    .selectedRetreatDate.value;
                            contractPlanController.setDate4();
                          } else {
                            contractPlanController.selectedTime4.value =
                                contractPlanController.timeList4[
                                    contractPlanController.selectIndex.value];

                            contractPlanController.selectedDate4.value =
                                contractPlanController
                                    .selectedRetreatDate.value;
                          }

                          // contractPlanController.update(["retreatPlanScreen"]);
                          contractPlanController.update();
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
