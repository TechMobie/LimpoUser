import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/data/models/checkout/checkout_model.dart';
import 'package:linpo_user/app/data/models/payment/get_card_model.dart';
import 'package:linpo_user/app/modules/MyWashingMachine/my_washing_machine_controller.dart';

import 'package:linpo_user/app/modules/plus/payment/payment_provider.dart';
import 'package:linpo_user/app/routes/app_pages.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/helper/utils/date_utils.dart';
import 'package:linpo_user/helper/utils/pref_utils.dart';

class PaymentController extends GetxController {
  GetCardModel getCardModel = GetCardModel();
  RxBool isShowLoadForWeb = false.obs;
  RxBool isShowOnePay = false.obs;
  bool isNoCardFound = false;
  String tbkToken = "";
  String createTokenForWebPaymentScreen = "";
  String webViewUrl = "";
  String createwebViewUrlForWebPaymentScreen = "";
  PaymentProvider paymentProvider = PaymentProvider();
  final myWashingMachineController = Get.find<MyWashingMachineController>();

  getCardApiCall() async {
    isNoCardFound = false;
    final response = await paymentProvider.getCard({});

    if (!isNullEmptyOrFalse(response)) {
      getCardModel = GetCardModel.fromJson(response);
      if (isNullEmptyOrFalse(getCardModel.data)) {
        isNoCardFound = true;
      }
    } else {
      isNoCardFound = true;
    }

    if (kDebugMode) {
      print(response);
    }
    update();
  }

  addCardApiCall({String? tbkToken}) async {
    CustomDialogs.getInstance.showProgressDialog();

    Map<String, dynamic> req = {
      "tbk_user": "71e1408b-bde6-4bae-b9bc-d0eb9ff39145",
      "authorization_code": "123",
      "card_type": "Visa",
      "card_number": "XXXXXXXXXXXX6623",
      "is_default_card": "0",
      "tbk_token": tbkToken
    };
    final response = await paymentProvider.addCard(req);
    if (!isNullEmptyOrFalse(response)) {
      await getCardApiCall();
      CustomDialogs.getInstance.hideProgressDialog();
    }

    if (kDebugMode) {
      print(response);
    }
  }

  confirmEnrollmentApiCall() async {
    CustomDialogs.getInstance.showProgressDialog();

    Map<String, dynamic> req = {"token": tbkToken};
    if (kDebugMode) {
      print("req $req");
    }
    final response = await paymentProvider.confirmEnrollment(req);
    if (!isNullEmptyOrFalse(response)) {
      if (kDebugMode) {
        print("Response $response");
      }
      await getCardApiCall();
      FacebookAppEvents().logEvent(name: "Add payment card");
      CustomDialogs.getInstance.hideProgressDialog();
    } else {
      CustomDialogs.getInstance.hideProgressDialog();
    }
  }

  createEnrollmentApiCall() async {
    CustomDialogs.getInstance.showProgressDialog();

    Map<String, dynamic> req = {};
    final response = await paymentProvider.createEnrollment(req);
    if (!isNullEmptyOrFalse(response)) {
      if (kDebugMode) {
        print(response);
      }
      tbkToken = response["data"]['token'];
      webViewUrl = response["data"]['urlWebpay'];
      CustomDialogs.getInstance.hideProgressDialog();
      isShowLoadForWeb.value = false;
      Get.toNamed(Routes.webViewScreen);
    } else {
      CustomDialogs.getInstance.hideProgressDialog();
    }
  }

  createTransactionApiCall() async {
    CustomDialogs.getInstance.showProgressDialog();

    Map<String, dynamic> req = {};
    final response = await paymentProvider.createTransaction(req);
    if (!isNullEmptyOrFalse(response)) {
      if (kDebugMode) {
        print(response);
      }
      createTokenForWebPaymentScreen = response["data"]['token'];
      createwebViewUrlForWebPaymentScreen = response["data"]['url'];
      CustomDialogs.getInstance.hideProgressDialog();
      isShowLoadForWeb.value = false;
      Get.toNamed(Routes.webPayMentScreen);
    } else {
      CustomDialogs.getInstance.hideProgressDialog();
    }
  }

  Future confirmTransactionApiCall(
      {String? token,
      String? userAddressid,
      String? pickUpDate,
      String? pickUpTime,
      String? deliveryDate,
      String? deliveryTime,
      String? whoWillReceive,
      String? comments}) async {
    CustomDialogs.getInstance.showProgressDialog();

    Map<String, dynamic> req = {
      "token": token,
      "user_address_id": userAddressid,
      "pickup_date": pickUpDate,
      "pickup_time": pickUpTime,
      "delivery_date": deliveryDate,
      "delivery_time": deliveryTime,
      "who_will_receive": whoWillReceive,
      "comments": comments,
      "payment_type": "webpay"
    };
    if (kDebugMode) {
      print("req $req");
    }
    final response = await paymentProvider.confirmTransaction(req);
    CustomDialogs.getInstance.hideProgressDialog();

    if (response['success'] == true) {
      myWashingMachineController.checkOutModel =
          CheckOutModel.fromJson(response);
    } else {}

    if (kDebugMode) {
      print("checkout response: $response");
    }
    return response;
  }

  deleteCardApiCall({
    String? userCardId,
  }) async {
    CustomDialogs.getInstance.showProgressDialog();
    final response =
        await paymentProvider.deleteCard({"user_card_id": userCardId});
    CustomDialogs.getInstance.hideProgressDialog();
    isNoCardFound = true;
    update();

    if (kDebugMode) {
      print(response);
    }
  }

  Future<void> editCardApiCall({String? userCardId, int? isDefaultCard}) async {
    CustomDialogs.getInstance.showProgressDialog();
    Map<String, dynamic> reqData = {
      "user_card_id": userCardId,
      "is_default_card": isNullEmptyOrFalse(isDefaultCard) ? 0 : 1
    };
    final response = await paymentProvider.editCard(reqData);

    if (kDebugMode) {
      print(response);
    }
    if (!isNullEmptyOrFalse(response)) {
      await getCardApiCall();
      CustomDialogs.getInstance.hideProgressDialog();
    }
  }

  @override
  void onInit() {
    if (PrefUtils.getInstance.isUserLogin()) {
      getCardApiCall();
    }
    super.onInit();
  }
}
