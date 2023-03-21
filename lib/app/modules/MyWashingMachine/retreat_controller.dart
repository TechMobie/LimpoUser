import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:linpo_user/helper/utils/pref_utils.dart';

class RetreatController extends GetxController {


  Rx<DateTime> pickUpSelectedDate = DateTime.now().obs;

  Rx<DateTime> deliverySelectedDate = DateTime.now().weekday == 5
      ? DateTime.now().add(const Duration(days: 3)).obs
      : DateTime.now().add(const Duration(days: 2)).obs;

  setPickUpDate() {
    String nameOfDay = DateFormat('EEEE').format(pickUpSelectedDate.value);
    if (kDebugMode) {
      print(nameOfDay);
    }

    if (nameOfDay == "Monday" ||
        nameOfDay == "Lunes" ||
        nameOfDay == "Wednesday" ||
        nameOfDay == "miércoles" ||
        nameOfDay == "Friday" ||
        nameOfDay == "Viernes" ||
        nameOfDay == "Tuesday" ||
        nameOfDay == "martes" ||
        nameOfDay == "Thursday" ||
        nameOfDay == "jueves" ||
        nameOfDay == "Sunday" ||
        nameOfDay == "Domingo") {
      pickUpSelectedDate.value =
          pickUpSelectedDate.value.add(const Duration(days: 1));
    } else if (nameOfDay == "Saturday" || nameOfDay == "sábado") {
      pickUpSelectedDate.value =
          pickUpSelectedDate.value.add(const Duration(days: 2));
    }
    selectedRetreatDate.value = pickUpSelectedDate.value;
    if (kDebugMode) {
      print(pickUpSelectedDate.value);
    }
    setDeliveryDate();
    update();
  }

  setDeliveryDate() {
    deliverySelectedDate.value = pickUpSelectedDate.value;
    String nameOfDay = DateFormat('EEEE').format(deliverySelectedDate.value);
    if (kDebugMode) {
      print(nameOfDay);
    }

    if (nameOfDay == "Monday" ||
        nameOfDay == "Lunes" ||
        nameOfDay == "Wednesday" ||
        nameOfDay == "miércoles" ||
        nameOfDay == "Tuesday" ||
        nameOfDay == "martes" ||
        nameOfDay == "Thursday" ||
        nameOfDay == "jueves" ||
        nameOfDay == "Sunday" ||
        nameOfDay == "Domingo") {
      deliverySelectedDate.value =
          deliverySelectedDate.value.add(const Duration(days: 2));
    } else if (nameOfDay == "Friday" ||
        nameOfDay == "Viernes" ||
        nameOfDay == "Saturday" ||
        nameOfDay == "sábado") {
      deliverySelectedDate.value =
          deliverySelectedDate.value.add(const Duration(days: 3));
    }
    selectedRetreatDate.value = deliverySelectedDate.value;
    if (kDebugMode) {
      print(deliverySelectedDate.value);
    }
    update();
  }

  int daysInMonth(DateTime date) => DateTimeRange(
          start: DateTime(date.year, date.month, 1),
          end: DateTime(date.year, date.month + 1))
      .duration
      .inDays;

  RxString isDeliverySelectedTime1 = "".obs;
  RxString isDeliverySelectedTime2 = "".obs;

  Rx<DateTime> selectedRetreatDate = DateTime.now().obs;

  RxList<String> pickUpList = ['09:00-13:00', '14:00-18:00'].obs;
  RxList<String> deliveryList = ['09:00-13:00', '14:00-18:00'].obs;
  RxInt selectIndex = 0.obs;
  RxString selectTimeForPickUp = "".obs;
  RxString selectTimeForDelivery = "".obs;
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (PrefUtils.getInstance.isUserLogin()) {

      setPickUpDate();
    }
  }
}

