import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:linpo_user/app/data/models/plans/get_type_of_plans.dart';
import 'package:linpo_user/app/modules/plans/plan_provider.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';

class OurPlanController extends GetxController {
  TextEditingController addCommentsController = TextEditingController();
  TextEditingController applyDiscountCodeController = TextEditingController();

  RxBool isCouponValid = false.obs;
  RxBool isCheckBox = false.obs;
  RxBool isCommentValid = true.obs;
  RxBool isCommentButtonValid = false.obs;
  PlanProvider plansProvider = PlanProvider();
  TypesOfPlansModel typesOfPlansModel = TypesOfPlansModel();

  RxBool showProgress = false.obs;

  // DateTime lastDateOfWeek = DateTime.now();
  // var week = Jiffy().week;
  // final myPlanController = Get.put<MyPlanController>(MyPlanController());

  // Rx<DateTime> selectedDate1 = DateTime.now().obs;
  // Rx<DateTime> selectedDate1_1 = DateTime.now().obs;
  // Rx<DateTime> selectedDate2 = DateTime.now().obs;
  // Rx<DateTime> selectedDate2_2 = DateTime.now().obs;
  // Rx<DateTime> selectedDate3 = DateTime.now().obs;
  // Rx<DateTime> selectedDate3_3 = DateTime.now().obs;
  // Rx<DateTime> selectedDate4 = DateTime.now().obs;
  // Rx<DateTime> selectedDate4_4 = DateTime.now().obs;

  // Rx<DateTime> selectedRetreatDate = DateTime.now().obs;

  // RxList<String> timeList1 = ['09:00-13:00', '14:00-18:00'].obs;
  // RxList<String> timeList2 = ['09:00-13:00', '14:00-18:00'].obs;
  // RxList<String> timeList3 = ['09:00-13:00', '14:00-18:00'].obs;
  // RxList<String> timeList4 = ['09:00-13:00', '14:00-18:00'].obs;
  // RxInt selectIndex = 0.obs;
  // RxString selectedTime1 = "09:00-13:00".obs;
  // RxString selectedTime2 = "09:00-13:00".obs;
  // RxString selectedTime3 = "09:00-13:00".obs;
  // RxString selectedTime4 = "09:00-13:00".obs;

  // CheckOutPlanModel checkOutPlanModel = CheckOutPlanModel();

  // setDate1() {
  //   String nameOfDay = DateFormat('EEEE').format(selectedDate1.value);
  //   if (kDebugMode) {
  //     print(nameOfDay);
  //   }

  //   if (kDebugMode) {
  //     print(daysInMonth(selectedDate1.value));
  //   }

  //   if (nameOfDay == "Monday" ||
  //       nameOfDay == "Lunes" ||
  //       nameOfDay == "Wednesday" ||
  //       nameOfDay == "miércoles" ||
  //       nameOfDay == "Tuesday" ||
  //       nameOfDay == "martes" ||
  //       nameOfDay == "Thursday" ||
  //       nameOfDay == "jueves" ||
  //       nameOfDay == "Sunday" ||
  //       nameOfDay == "Domingo" ||
  //       nameOfDay == "Friday" ||
  //       nameOfDay == "Viernes") {
  //     selectedDate1.value = selectedDate1.value.add(const Duration(days: 1));
  //   } else if (nameOfDay == "Saturday" || nameOfDay == "sábado") {
  //     selectedDate1.value = selectedDate1.value.add(const Duration(days: 2));
  //   }
  //   selectedRetreatDate.value = selectedDate1.value;
  //   if (kDebugMode) {
  //     print(selectedDate1.value);
  //   }
  //   setDate2();
  //   update();
  // }

  // setDate2() {
  //   selectedDate2.value = selectedDate1.value;
  //   String nameOfDay = DateFormat('EEEE').format(selectedDate2.value);
  //   if (kDebugMode) {
  //     print(nameOfDay);
  //   }

  //   selectedDate2.value = selectedDate2.value.add(const Duration(days: 7));

  //   selectedRetreatDate.value = selectedDate2.value;

  //   if (kDebugMode) {
  //     print(selectedDate2.value);
  //   }
  //   setDate3();
  //   update();
  // }

  // setDate3() {
  //   selectedDate3.value = selectedDate2.value;
  //   String nameOfDay = DateFormat('EEEE').format(selectedDate3.value);
  //   if (kDebugMode) {
  //     print(nameOfDay);
  //   }

  //   selectedDate3.value = selectedDate3.value.add(const Duration(days: 7));

  //   selectedRetreatDate.value = selectedDate3.value;
  //   setDate4();
  //   if (kDebugMode) {
  //     print(selectedDate3.value);
  //   }
  //   update();
  // }

  // setDate4() {
  //   selectedDate4.value = selectedDate3.value;
  //   String nameOfDay = DateFormat('EEEE').format(selectedDate4.value);
  //   if (kDebugMode) {
  //     print(nameOfDay);
  //   }

  //   selectedDate4.value = selectedDate4.value.add(const Duration(days: 7));

  //   selectedRetreatDate.value = selectedDate4.value;
  //   if (kDebugMode) {
  //     print(selectedDate4.value);
  //   }
  //   update();
  // }

  // int daysInMonth(DateTime date) => DateTimeRange(
  //         start: DateTime(date.year, date.month, 1),
  //         end: DateTime(date.year, date.month + 1))
  //     .duration
  //     .inDays;

  getTypeOfPlansApiCall() async {
    showProgress.value = true;

    final response = await plansProvider.getTypeOfPlans({});
    if (!isNullEmptyOrFalse(response)) {
      typesOfPlansModel = TypesOfPlansModel.fromJson(response);
      showProgress.value = false;
    }
    update();

    if (kDebugMode) {
      print("contract plan $response");
    }
  }

  DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
  }

  DateTime findLastDateOfTheWeek(DateTime dateTime) {
    return dateTime
        .add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
  }

  // createDateAndSet() async {
  //   lastDateOfWeek = findLastDateOfTheWeek(lastDateOfWeek);
  //   return findFirstDateOfTheWeek(lastDateOfWeek);
  // }

  // firstDateCreateAndSet() {
  //   String nameOfDay = DateFormat('EEEE').format(DateTime.now());
  //   if (nameOfDay == "Sunday" || nameOfDay == "Domingo") {
  //     week++;
  //     lastDateOfWeek = lastDateOfWeek.add(const Duration(days: 1));
  //   } else if (nameOfDay == "Saturday" || nameOfDay == "sábado") {
  //     week++;
  //     lastDateOfWeek = lastDateOfWeek.add(const Duration(days: 2));
  //   }
  //   if (week == 53) {
  //     lastDateOfWeek = DateTime(lastDateOfWeek.year + 1);
  //   }

  //   lastDateOfWeek = findLastDateOfTheWeek(lastDateOfWeek);
  //   return findFirstDateOfTheWeek(lastDateOfWeek);
  // }

  // checkoutPlanApiCall(
  //     {String? planId,
  //     String? typeOfPlanId,
  //     String? userAddressId,
  //     int? amount,
  //     String? pickUpDate1,
  //     String? pickUpTime1,
  //     String? deliveryDate1,
  //     String? deliveryTime1,
  //     String? pickUpDate2,
  //     String? pickUpTime2,
  //     String? deliveryDate2,
  //     String? deliveryTime2,
  //     String? pickUpDate3,
  //     String? pickUpTime3,
  //     String? deliveryDate3,
  //     String? deliveryTime3,
  //     String? pickUpDate4,
  //     String? pickUpTime4,
  //     String? deliveryDate4,
  //     String? deliveryTime4}) async {
  //   CustomDialogs.getInstance.showProgressDialog();

  //   Map<String, dynamic> reqData = {
  //     "plan_id": planId.toString(), //"1",
  //     "type_of_plan_id": typeOfPlanId.toString(), //"1",
  //     "user_address_id": userAddressId.toString(), //"1",
  //     "comments": addCommentsController.text.trimRight(), //"test comment",
  //     "amount": amount, //10.11,
  //     "start_date": DateUtilities.convertDateTimeToString(
  //         date: DateTime.now(), dateFormatter: DateUtilities.yyyy_mm_dd),

  //     "end_date": DateUtilities.convertDateTimeToString(
  //         date: findLastDateOfTheWeek(selectedDate4.value)
  //             .subtract(const Duration(days: 1)),
  //         dateFormatter: DateUtilities.yyyy_mm_dd),

  //     "renewal_date": DateUtilities.convertDateTimeToString(
  //         date: findFirstDateOfTheWeek(selectedDate4.value),
  //         dateFormatter: DateUtilities.yyyy_mm_dd),

  //     "order_date": [
  //       {
  //         "pickup_date": pickUpDate1,
  //         "pickup_time": pickUpTime1,
  //         "delivery_date": deliveryDate1,
  //         "delivery_time": deliveryTime1,
  //       },
  //       {
  //         "pickup_date": pickUpDate2,
  //         "pickup_time": pickUpTime2,
  //         "delivery_date": deliveryDate2,
  //         "delivery_time": deliveryTime2,
  //       },
  //       {
  //         "pickup_date": pickUpDate3,
  //         "pickup_time": pickUpTime3,
  //         "delivery_date": deliveryDate3,
  //         "delivery_time": deliveryTime3,
  //       },
  //       {
  //         "pickup_date": pickUpDate4,
  //         "pickup_time": pickUpTime4,
  //         "delivery_date": deliveryDate4,
  //         "delivery_time": deliveryTime4,
  //       }
  //     ]
  //   };
  //   if (kDebugMode) {
  //     print("checkout reqData plan: $reqData");
  //   }
  //   final response = await plansProvider.checkoutPlan(reqData);

  //   CustomDialogs.getInstance.hideProgressDialog();

  //   if (response['success'] == true) {
  //     checkOutPlanModel = CheckOutPlanModel.fromJson(response);
  //     Get.toNamed(Routes.successfulScreen);
  //     await myPlanController.getPlanApiCall();
  //   } else {
  //     showToast(
  //         msg: response['message'].toString(),
  //         color: ColorSchema.redColor.withOpacity(0.5));
  //   }
  //   if (kDebugMode) {
  //     print("checkout response plan: $response");
  //   }
  //   update();
  // }

  // getDate() async {
  //   selectedDate1_1.value = await firstDateCreateAndSet();
  //   lastDateOfWeek = lastDateOfWeek.add(const Duration(days: 7));
  //   selectedDate2_2.value = await createDateAndSet();
  //   lastDateOfWeek = lastDateOfWeek.add(const Duration(days: 7));
  //   selectedDate3_3.value = await createDateAndSet();
  //   lastDateOfWeek = lastDateOfWeek.add(const Duration(days: 7));
  //   selectedDate4_4.value = await createDateAndSet();
  // }

  @override
  void onInit() {
    // getDate();
    // setDate1();
    getTypeOfPlansApiCall();
    super.onInit();
  }
}
