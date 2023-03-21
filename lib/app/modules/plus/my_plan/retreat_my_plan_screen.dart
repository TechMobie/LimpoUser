import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linpo_user/components/button/button.dart';
import 'package:linpo_user/components/common_class.dart';
import 'package:linpo_user/helper/utils/constants.dart';
import 'package:linpo_user/helper/utils/date_utils.dart';
import 'package:linpo_user/helper/utils/enum.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'my_plan_controller.dart';

class RetreatMyPlanScreen extends StatefulWidget {
  const RetreatMyPlanScreen({Key? key}) : super(key: key);

  @override
  State<RetreatMyPlanScreen> createState() => _RetreatMyPlanScreenState();
}

class _RetreatMyPlanScreenState extends State<RetreatMyPlanScreen> {
  final myPlanController = Get.put<MyPlanController>(MyPlanController());
  EnumForMyPlanRetreat? enumForMyPlanRetreat =
      Get.arguments[0] ?? EnumForMyPlanRetreat.withdrawal1;
  int index1 = Get.arguments[1] ?? 0;

  @override
  Widget build(BuildContext context) {
    enumForMyPlanRetreat == EnumForMyPlanRetreat.withdrawal1
        ? myPlanController.selectedRetreatDate.value =
            myPlanController.selectedDate1.value
        : enumForMyPlanRetreat == EnumForMyPlanRetreat.withdrawal2
            ? myPlanController.selectedRetreatDate.value =
                myPlanController.selectedDate2.value
            : enumForMyPlanRetreat == EnumForMyPlanRetreat.withdrawal3
                ? myPlanController.selectedRetreatDate.value =
                    myPlanController.selectedDate3.value
                : myPlanController.selectedRetreatDate.value =
                    myPlanController.selectedDate4.value;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
            child: SafeArea(
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
                      enumForMyPlanRetreat == EnumForMyPlanRetreat.withdrawal1
                          ? DateTime.now().add(const Duration(days: 1))
                          : enumForMyPlanRetreat ==
                                  EnumForMyPlanRetreat.withdrawal2
                              ? myPlanController.selectedDate2_2.value
                              : enumForMyPlanRetreat ==
                                      EnumForMyPlanRetreat.withdrawal3
                                  ? myPlanController.selectedDate3_3.value
                                  : myPlanController.selectedDate4_4.value,
                      height: 93,
                      initialSelectedDate: enumForMyPlanRetreat ==
                              EnumForMyPlanRetreat.withdrawal1
                          ? myPlanController.selectedDate1.value
                          : enumForMyPlanRetreat ==
                                  EnumForMyPlanRetreat.withdrawal2
                              ? myPlanController.selectedDate2.value
                              : enumForMyPlanRetreat ==
                                      EnumForMyPlanRetreat.withdrawal3
                                  ? myPlanController.selectedDate3.value
                                  : myPlanController.selectedDate4.value,
                      selectionColor: ColorSchema.babyBlueColor,
                      selectedTextColor: ColorSchema.primaryColor,
                      deactivatedColor: ColorSchema.babyBlueColor,
                      locale: myLocale.toString(),
                      activeDates: [
                        enumForMyPlanRetreat == EnumForMyPlanRetreat.withdrawal1
                            ? myPlanController.selectedDate1_1.value
                            : enumForMyPlanRetreat ==
                                    EnumForMyPlanRetreat.withdrawal2
                                ? myPlanController.selectedDate2_2.value
                                : enumForMyPlanRetreat ==
                                        EnumForMyPlanRetreat.withdrawal3
                                    ? myPlanController.selectedDate3_3.value
                                    : myPlanController.selectedDate4_4.value,
                        for (int i = 1; i <= 5; i++)
                          enumForMyPlanRetreat ==
                                  EnumForMyPlanRetreat.withdrawal1
                              ? myPlanController.selectedDate1_1.value
                                  .add(Duration(days: i))
                              : enumForMyPlanRetreat ==
                                      EnumForMyPlanRetreat.withdrawal2
                                  ? myPlanController.selectedDate2_2.value
                                      .add(Duration(days: i))
                                  : enumForMyPlanRetreat ==
                                          EnumForMyPlanRetreat.withdrawal3
                                      ? myPlanController.selectedDate3_3.value
                                          .add(Duration(days: i))
                                      : myPlanController.selectedDate4_4.value
                                          .add(Duration(days: i)),
                      ],
                      onDateChange: (date) {
                        myPlanController.selectedRetreatDate.value = date;
                        myPlanController.update();
                      },
                    ),
                    SizedBox(
                      height: getSize(15),
                    ),
                    GetBuilder(
                      id: "retreatMyPlanScreen",
                      init: MyPlanController(),
                      builder: (controller) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: enumForMyPlanRetreat ==
                                    EnumForMyPlanRetreat.withdrawal1
                                ? myPlanController.timeList1.length
                                : enumForMyPlanRetreat ==
                                        EnumForMyPlanRetreat.withdrawal2
                                    ? myPlanController.timeList2.length
                                    : enumForMyPlanRetreat ==
                                            EnumForMyPlanRetreat.withdrawal3
                                        ? myPlanController.timeList3.length
                                        : myPlanController.timeList4.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  myPlanController.selectIndex.value = index;
                                  myPlanController
                                      .update(["retreatMyPlanScreen"]);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: getSize(15),
                                  ),
                                  height: getSize(55),
                                  width: MathUtilities.screenWidth(context),
                                  color: myPlanController.selectIndex.value ==
                                          index
                                      ? ColorSchema.babyBlueColor
                                      : ColorSchema.greyColor,
                                  child: Row(
                                    children: [
                                      Text(
                                        enumForMyPlanRetreat ==
                                                EnumForMyPlanRetreat.withdrawal1
                                            ? myPlanController.timeList1[index]
                                            : enumForMyPlanRetreat ==
                                                    EnumForMyPlanRetreat
                                                        .withdrawal2
                                                ? myPlanController
                                                    .timeList2[index]
                                                : enumForMyPlanRetreat ==
                                                        EnumForMyPlanRetreat
                                                            .withdrawal3
                                                    ? myPlanController
                                                        .timeList3[index]
                                                    : myPlanController
                                                        .timeList4[index],
                                        style: const TextStyle()
                                            .normal16
                                            .textColor(myPlanController
                                                        .selectIndex.value ==
                                                    index
                                                ? ColorSchema.primaryColor
                                                : ColorSchema.blackColor),
                                      ),
                                      const Spacer(),
                                      myPlanController.selectIndex.value ==
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
                                              .textColor(myPlanController
                                                          .selectIndex.value ==
                                                      index
                                                  ? ColorSchema.primaryColor
                                                  : ColorSchema.blackColor))
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
                        text: enumForMyPlanRetreat ==
                                EnumForMyPlanRetreat.withdrawal1
                            ? "${AppLocalizations.of(context)!.confirmWithdrawal} 1"
                            : enumForMyPlanRetreat ==
                                    EnumForMyPlanRetreat.withdrawal2
                                ? "${AppLocalizations.of(context)!.confirmWithdrawal} 2"
                                : enumForMyPlanRetreat ==
                                        EnumForMyPlanRetreat.withdrawal3
                                    ? "${AppLocalizations.of(context)!.confirmWithdrawal} 3"
                                    : "${AppLocalizations.of(context)!.confirmDispatch} 4",
                        onTap: () {
                          if (enumForMyPlanRetreat ==
                              EnumForMyPlanRetreat.withdrawal1) {
                            myPlanController.selectedTime1.value =
                                myPlanController.timeList1[
                                    myPlanController.selectIndex.value];

                            myPlanController.selectedDate1.value =
                                myPlanController.selectedRetreatDate.value;
                            myPlanController.editOrderApiCall(
                              orderId: myPlanController
                                  .getPlanModel.data?[index1].orders?[0].id,
                              deliveryDate:
                                  DateUtilities.convertDateTimeToString(
                                      date: myPlanController.selectedDate1.value
                                                      .weekday ==
                                                  5 ||
                                              myPlanController.selectedDate1
                                                      .value.weekday ==
                                                  6
                                          ? myPlanController
                                              .selectedDate1.value
                                              .add(const Duration(days: 3))
                                          : myPlanController.selectedDate1.value
                                              .add(const Duration(days: 2)),
                                      dateFormatter: DateUtilities.yyyy_mm_dd),
                              deliveryTime:
                                  myPlanController.selectedTime1.value ==
                                          "09:00-13:00"
                                      ? "09:00-13:00"
                                      : "14:00-18:00",
                              pickUpDate: DateUtilities.convertDateTimeToString(
                                  date: myPlanController.selectedDate1.value,
                                  dateFormatter: DateUtilities.yyyy_mm_dd),
                              pickUpTime:
                                  myPlanController.selectedTime1.value ==
                                          "09:00-13:00"
                                      ? "09:00-13:00"
                                      : "14:00-18:00",
                            );
                            //myPlanController.setDate2();
                          } else if (enumForMyPlanRetreat ==
                              EnumForMyPlanRetreat.withdrawal2) {
                            myPlanController.selectedTime2.value =
                                myPlanController.timeList2[
                                    myPlanController.selectIndex.value];

                            myPlanController.selectedDate2.value =
                                myPlanController.selectedRetreatDate.value;

                            myPlanController.editOrderApiCall(
                              orderId: myPlanController
                                  .getPlanModel.data?[index1].orders?[1].id,
                              deliveryDate:
                                  DateUtilities.convertDateTimeToString(
                                      date: myPlanController.selectedDate2.value
                                                      .weekday ==
                                                  5 ||
                                              myPlanController.selectedDate2
                                                      .value.weekday ==
                                                  6
                                          ? myPlanController
                                              .selectedDate2.value
                                              .add(const Duration(days: 3))
                                          : myPlanController.selectedDate2.value
                                              .add(const Duration(days: 2)),
                                      dateFormatter: DateUtilities.yyyy_mm_dd),
                              deliveryTime:
                                  myPlanController.selectedTime2.value ==
                                          "09:00-13:00"
                                      ? "09:00-13:00"
                                      : "14:00-18:00",
                              pickUpDate: DateUtilities.convertDateTimeToString(
                                  date: myPlanController.selectedDate2.value,
                                  dateFormatter: DateUtilities.yyyy_mm_dd),
                              pickUpTime:
                                  myPlanController.selectedTime2.value ==
                                          "09:00-13:00"
                                      ? "09:00-13:00"
                                      : "14:00-18:00",
                            );
                            // myPlanController.setDate3();
                          } else if (enumForMyPlanRetreat ==
                              EnumForMyPlanRetreat.withdrawal3) {
                            myPlanController.selectedTime3.value =
                                myPlanController.timeList3[
                                    myPlanController.selectIndex.value];

                            myPlanController.selectedDate3.value =
                                myPlanController.selectedRetreatDate.value;
                            myPlanController.editOrderApiCall(
                              orderId: myPlanController
                                  .getPlanModel.data?[index1].orders?[2].id,
                              deliveryDate:
                                  DateUtilities.convertDateTimeToString(
                                      date: myPlanController.selectedDate3.value
                                                      .weekday ==
                                                  5 ||
                                              myPlanController.selectedDate3
                                                      .value.weekday ==
                                                  6
                                          ? myPlanController
                                              .selectedDate3.value
                                              .add(const Duration(days: 3))
                                          : myPlanController.selectedDate3.value
                                              .add(const Duration(days: 2)),
                                      dateFormatter: DateUtilities.yyyy_mm_dd),
                              deliveryTime:
                                  myPlanController.selectedTime3.value ==
                                          "09:00-13:00"
                                      ? "09:00-13:00"
                                      : "14:00-18:00",
                              pickUpDate: DateUtilities.convertDateTimeToString(
                                  date: myPlanController.selectedDate3.value,
                                  dateFormatter: DateUtilities.yyyy_mm_dd),
                              pickUpTime:
                                  myPlanController.selectedTime3.value ==
                                          "09:00-13:00"
                                      ? "09:00-13:00"
                                      : "14:00-18:00",
                            );
                          } else {
                            myPlanController.selectedTime4.value =
                                myPlanController.timeList4[
                                    myPlanController.selectIndex.value];

                            myPlanController.selectedDate4.value =
                                myPlanController.selectedRetreatDate.value;

                            myPlanController.editOrderApiCall(
                              orderId: myPlanController
                                  .getPlanModel.data?[index1].orders?[3].id,
                              deliveryDate:
                                  DateUtilities.convertDateTimeToString(
                                      date: myPlanController.selectedDate4.value
                                                      .weekday ==
                                                  5 ||
                                              myPlanController.selectedDate4
                                                      .value.weekday ==
                                                  6
                                          ? myPlanController
                                              .selectedDate4.value
                                              .add(const Duration(days: 3))
                                          : myPlanController.selectedDate4.value
                                              .add(const Duration(days: 2)),
                                      dateFormatter: DateUtilities.yyyy_mm_dd),
                              deliveryTime:
                                  myPlanController.selectedTime4.value ==
                                          "09:00-13:00"
                                      ? "09:00-13:00"
                                      : "14:00-18:00",
                              pickUpDate: DateUtilities.convertDateTimeToString(
                                  date: myPlanController.selectedDate4.value,
                                  dateFormatter: DateUtilities.yyyy_mm_dd),
                              pickUpTime:
                                  myPlanController.selectedTime4.value ==
                                          "09:00-13:00"
                                      ? "09:00-13:00"
                                      : "14:00-18:00",
                            );
                          }
                          myPlanController.selectIndex.value = 0;

                          myPlanController.update(["retreatMyPlanScreen"]);
                          myPlanController.update();
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
        ))),
      ),
    );
  }
}
