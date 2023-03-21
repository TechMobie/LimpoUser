import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/data/models/checkout/checkout_model.dart';
import 'package:linpo_user/app/data/models/generalModel/general_model.dart';
import 'package:linpo_user/app/data/models/my_washing_machine/get_cart_model.dart';
import 'package:linpo_user/app/modules/MyWashingMachine/my_washing_machine_provider.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/helper/utils/pref_utils.dart';

class MyWashingMachineController extends GetxController {
  //step1 screen.....
  RxInt counter = 0.obs;

  //step2 screen ...........
  RxBool checkValue1 = true.obs;
  RxBool checkValue2 = false.obs;
  RxBool checkValue3 = false.obs;
  TextEditingController addCommentsController = TextEditingController();
  TextEditingController personReceiveController = TextEditingController();

  //step3 screen ....
  TextEditingController applyDiscountCodeController = TextEditingController();
  RxBool isCouponValid = false.obs;
  GetCartModel getCartModel = GetCartModel();
  GeneralModel generalModel = GeneralModel();
  MyWashingMachineProvider myWashingMachineProvider =
      MyWashingMachineProvider();
  int grandTotalPrice = 0;
  RxBool showProgress = false.obs;

  CheckOutModel checkOutModel = CheckOutModel();

  Future getCartApiCall() async {
    showProgress.value = true;

    grandTotalPrice = 0;

    final response = await myWashingMachineProvider.getCart({});
    if (!isNullEmptyOrFalse(response)) {
      getCartModel = GetCartModel.fromJson(response);

      grandTotalPrice = !isNullEmptyOrFalse(getCartModel.data!.totalAmount)
          ? int.parse(getCartModel.data!.totalAmount.toString())
          : 0;
      if (kDebugMode) {
        print(grandTotalPrice);
      }

      showProgress.value = false;
    }

    if (kDebugMode) {
      print(response);
    }
    update();
  }

  Future getGeneralSettingApiCall() async {
    final response = await myWashingMachineProvider.generalSetting({});
    if (!isNullEmptyOrFalse(response)) {
      generalModel = GeneralModel.fromJson(response);

      if (kDebugMode) {
        print(generalModel
            .data?.generalSetting?.minimumOrderAmountForFreeShipping);
      }
    }

    if (kDebugMode) {
      print(response);
    }
    update();
  }

  Future checkOutApiCall(
      {String? userAddressId,
      String? pickUpDate,
      String? pickUpTime,
      String? deliveryDate,
      String? deliveryTime,
      String? whoWillReceive,
      String? comments}) async {
    CustomDialogs.getInstance.showProgressDialog();

    Map<String, dynamic> reqData = {
      "user_address_id": userAddressId.toString(),
      "pickup_date": pickUpDate,
      "pickup_time": pickUpTime,
      "delivery_date": deliveryDate,
      "delivery_time": deliveryTime,
      "who_will_receive": whoWillReceive,
      "comments": comments,
      "payment_type": "oneclick"
    };
    if (kDebugMode) {
      print("checkout reqData: $reqData");
    }

    final response = await myWashingMachineProvider.checkOut(reqData);
    CustomDialogs.getInstance.hideProgressDialog();

    if (response['success'] == false) {
    } else {
      checkOutModel = CheckOutModel.fromJson(response);
    }

    if (kDebugMode) {
      print("checkout response: $response");
    }
    return response;
  }

  @override
  void onInit() {
    if (PrefUtils.getInstance.isUserLogin()) {
      getCartApiCall();
      getGeneralSettingApiCall();
      // setPickUpDate();
    }

    // TODO: implement onInit
    super.onInit();
  }
}
