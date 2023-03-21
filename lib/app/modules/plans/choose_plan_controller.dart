import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/data/models/plans/plans_model.dart';
import 'package:linpo_user/app/modules/plans/choose_plan_screen.dart';
import 'package:linpo_user/app/modules/plans/plan_provider.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';

class ChoosePlanController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    getPlansApiCall();
    super.onInit();
  }

  PlanProvider plansProvider = PlanProvider();
  PlansModel plansModel = PlansModel();

  RxBool showProgress = false.obs;

  getPlansApiCall({int? id, int? index}) async {
    // CustomDialogs.getInstance.showProgressDialog();
    showProgress.value = true;

    Map<String, dynamic> reqData = {
      "type_of_plan_id": Get.arguments[0],
    };
    if (kDebugMode) {
      print(reqData);
    }
    try {
      final response = await plansProvider.getPlans(reqData);
      if (!isNullEmptyOrFalse(response)) {
        plansModel = PlansModel.fromJson(response);
      showProgress.value = false;
      }

      // CustomDialogs.getInstance.hideProgressDialog();
      // Navigator.push(
      //     Get.context!,
      //     MaterialPageRoute(
      //         builder: (context) => ChoosePlanScreen(ind: index)));

      if (kDebugMode) {
        print(response);
      }
    } catch (e) {
      CustomDialogs.getInstance.hideProgressDialog();
      if (kDebugMode) {
        print(e);
      }
      // TODO
    }
    update();
  }
}
