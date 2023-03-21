

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:linpo_user/app/data/models/plans/get_plan_model.dart';
import 'package:linpo_user/app/modules/plans/plan_provider.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/helper/utils/pref_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';

class MyPlanController extends GetxController {
  PlanProvider plansProvider = PlanProvider();
  GetPlanModel getPlanModel = GetPlanModel();
  RxBool showProgress1 = false.obs;
  Rx<DateTime> selectedDate1 = DateTime.now().obs;
  Rx<DateTime> selectedDate1_1 = DateTime.now().obs;
  Rx<DateTime> selectedDate2 = DateTime.now().obs;
  Rx<DateTime> selectedDate2_2 = DateTime.now().obs;
  Rx<DateTime> selectedDate3 = DateTime.now().obs;
  Rx<DateTime> selectedDate3_3 = DateTime.now().obs;
  Rx<DateTime> selectedDate4 = DateTime.now().obs;
  Rx<DateTime> selectedDate4_4 = DateTime.now().obs;

  Rx<DateTime> selectedRetreatDate = DateTime.now().obs;

  RxList<String> timeList1 = ['09:00-13:00', '14:00-18:00'].obs;
  RxList<String> timeList2 = ['09:00-13:00', '14:00-18:00'].obs;
  RxList<String> timeList3 = ['09:00-13:00', '14:00-18:00'].obs;
  RxList<String> timeList4 = ['09:00-13:00', '14:00-18:00'].obs;
  RxInt selectIndex = 0.obs;
  RxString selectedTime1 = "09:00-13:00".obs;
  RxString selectedTime2 = "09:00-13:00".obs;
  RxString selectedTime3 = "09:00-13:00".obs;
  RxString selectedTime4 = "09:00-13:00".obs;
  RxBool showProgress = false.obs;
  DateTime lastDateOfWeek = DateTime.now();
  var week = Jiffy().week;

  DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
  }

  DateTime findLastDateOfTheWeek(DateTime dateTime) {
    return dateTime
        .add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
  }

  createDateAndSet() async {
    lastDateOfWeek = findLastDateOfTheWeek(lastDateOfWeek);
    return findFirstDateOfTheWeek(lastDateOfWeek);
  }

  firstDateCreateAndSet() {
    String? nameOfDay;

    if (!isNullEmptyOrFalse(getPlanModel.data)) {
      nameOfDay = DateFormat('EEEE')
          .format(DateTime.parse(getPlanModel.data![0].startDate.toString()));
    }
    if (nameOfDay == "Sunday" || nameOfDay == "Domingo") {
      week++;
      lastDateOfWeek = lastDateOfWeek.add(const Duration(days: 1));
    } else if (nameOfDay == "Saturday" || nameOfDay == "sábado") {
      week++;
      lastDateOfWeek = lastDateOfWeek.add(const Duration(days: 2));
    }
    if (week == 53) {
      lastDateOfWeek = DateTime(lastDateOfWeek.year + 1);
    }

    lastDateOfWeek = findLastDateOfTheWeek(lastDateOfWeek);
    return findFirstDateOfTheWeek(lastDateOfWeek);
  }

  getDate() async {
    selectedDate1_1.value = await firstDateCreateAndSet();
    lastDateOfWeek = lastDateOfWeek.add(const Duration(days: 7));
    selectedDate2_2.value = await createDateAndSet();
    lastDateOfWeek = lastDateOfWeek.add(const Duration(days: 7));
    selectedDate3_3.value = await createDateAndSet();
    lastDateOfWeek = lastDateOfWeek.add(const Duration(days: 7));
    selectedDate4_4.value = await createDateAndSet();
  }

  getPlanApiCall() async {
    showProgress1.value = true;
    Map<String, dynamic> reqData = {};
    if (kDebugMode) {
      print(reqData);
    }
    final response = await plansProvider.getPlan(reqData);
    if (!isNullEmptyOrFalse(response)) {
      getPlanModel = GetPlanModel.fromJson(response);

      if (!isNullEmptyOrFalse(getPlanModel.data)) {
        getPlanModel.data?[0].isMyDetail = true;
        lastDateOfWeek =
            DateTime.parse(getPlanModel.data![0].startDate.toString());
        selectedDate1_1.value =
            DateTime.parse(getPlanModel.data![0].startDate.toString());
        selectedDate2_2.value =
            DateTime.parse(getPlanModel.data![0].startDate.toString());
        selectedDate3_3.value =
            DateTime.parse(getPlanModel.data![0].startDate.toString());
        selectedDate4_4.value =
            DateTime.parse(getPlanModel.data![0].startDate.toString());
      }

      showProgress1.value = false;
    }
    if (kDebugMode) {
      print(response);
    }
    await getDate();
    update();
  }

  cancelPlanApiCall({String? planId}) async {
    Map<String, dynamic> reqData = {"user_plan_id": planId};
    if (kDebugMode) {
      print(reqData);
    }
    final response = await plansProvider.cancelPlan(reqData);
    if (response['success'] == true) {
      Get.back();
      showToast(
        msg: response['message'].toString(),
        color: ColorSchema.greenColor.withOpacity(0.3),
      );
      await getPlanApiCall();
    }

    if (kDebugMode) {
      print(response);
    }
    update();
  }

  int? userPlanId = 0;

  editPlanAddressApiCall({int? userPlanId, int? userAddressId}) async {
showProgress.value=true;
    Map<String, dynamic> reqData = {
      "user_plan_id": userPlanId,
      "user_address_id": userAddressId
    };
    if (kDebugMode) {
      print(reqData);
    }

    final response = await plansProvider.editPlan(reqData);

    if (!isNullEmptyOrFalse(response)) {
      await getPlanApiCall();
      showProgress.value= false;

    }

    // if (kDebugMode) {
    //   print(response);
    // }
    update();
  }

  editOrderApiCall({
    int? orderId,
    String? pickUpDate,
    String? pickUpTime,
    String? deliveryDate,
    String? deliveryTime,
  }) async {
    Map<String, dynamic> reqData = {
      "order_id": orderId,
      "pickup_date": pickUpDate,
      "pickup_time": pickUpTime,
      "delivery_date": deliveryDate,
      "delivery_time": deliveryTime
    };
    if (kDebugMode) {
      print(reqData);
    }
    final response = await plansProvider.editOrder(reqData);
    if (!isNullEmptyOrFalse(response)) {
      getPlanApiCall();
    }

    if (kDebugMode) {
      print(response);
    }
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    if (PrefUtils.getInstance.isUserLogin()) {
      await getPlanApiCall();
      // await getDate();
    }
  }
}
