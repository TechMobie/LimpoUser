import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/data/models/my_orders/my_orders_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linpo_user/app/modules/plus/my_orders/my_orders_provider.dart';
import 'package:linpo_user/helper/utils/pref_utils.dart';

class MyOrderController extends GetxController {
  final myOrdersProvider = Get.put(MyOrdersProvider());
  MyOrderModel myOrderModel = MyOrderModel();
  RxBool showProgress = false.obs;

  apiCallForGetOrderDetails() async {
    showProgress.value = true;
    myOrderModel = MyOrderModel();
    final response = await myOrdersProvider.orderDetailsApiCall();
    if (response != null) {
      myOrderModel = MyOrderModel.fromJson(response);

      for (int i = 0; i < myOrderModel.data!.length; i++) {
        myOrderModel.data![i].finalOrderStatus!.addAll({
          CustomOrderStatus(
              date: "",
              isOrderStatus: false,
              statusId: 1,
              status: AppLocalizations.of(Get.context!)!.orderPlaced),
          CustomOrderStatus(
              date: "",
              isOrderStatus: false,
              statusId: 4,
              status: AppLocalizations.of(Get.context!)!.orderInProcess),
          CustomOrderStatus(
              date: "",
              isOrderStatus: false,
              statusId: 6,
              status: AppLocalizations.of(Get.context!)!.orderPickup),
          CustomOrderStatus(
              date: "",
              isOrderStatus: false,
              statusId: 13,
              status: AppLocalizations.of(Get.context!)!.orderOnTheWay),
          CustomOrderStatus(
              date: "",
              isOrderStatus: false,
              statusId: 15,
              status: AppLocalizations.of(Get.context!)!.orderDelivered),
        });
        myOrderModel.data!.first.isDetail = false;
        for (int j = 0; j < myOrderModel.data![i].orderStatus!.length; j++) {
          if (myOrderModel.data![i].orderStatus![j].orderStatusId == 1) {
            myOrderModel.data![i].finalOrderStatus![0].status =
                myOrderModel.data![i].orderStatus![j].orderStatus;

            myOrderModel.data![i].finalOrderStatus![0].isOrderStatus = true;
            myOrderModel.data![i].finalOrderStatus![0].date =
                myOrderModel.data![i].orderStatus![j].createdAt.toString();
          }
          if (myOrderModel.data![i].orderStatus![j].orderStatusId == 4) {
            myOrderModel.data![i].finalOrderStatus![1].status =
                myOrderModel.data![i].orderStatus![j].orderStatus;
            myOrderModel.data![i].finalOrderStatus![1].isOrderStatus = true;
            myOrderModel.data![i].finalOrderStatus![1].date =
                myOrderModel.data![i].orderStatus![j].createdAt.toString();
          }
          if (myOrderModel.data![i].orderStatus![j].orderStatusId == 6) {
            myOrderModel.data![i].finalOrderStatus![2].status =
                myOrderModel.data![i].orderStatus![j].orderStatus;
            myOrderModel.data![i].finalOrderStatus![2].isOrderStatus = true;
            myOrderModel.data![i].finalOrderStatus![2].date =
                myOrderModel.data![i].orderStatus![j].createdAt.toString();
          }
          if (myOrderModel.data![i].orderStatus![j].orderStatusId == 13) {
            myOrderModel.data![i].finalOrderStatus![3].status =
                myOrderModel.data![i].orderStatus![j].orderStatus;
            myOrderModel.data![i].finalOrderStatus![3].isOrderStatus = true;
            myOrderModel.data![i].finalOrderStatus![3].date =
                myOrderModel.data![i].orderStatus![j].createdAt.toString();
          }
          if (myOrderModel.data![i].orderStatus![j].orderStatusId == 15) {
            myOrderModel.data![i].finalOrderStatus![4].status =
                myOrderModel.data![i].orderStatus![j].orderStatus;
            myOrderModel.data![i].finalOrderStatus![4].isOrderStatus = true;
            myOrderModel.data![i].finalOrderStatus![4].date =
                myOrderModel.data![i].orderStatus![j].createdAt.toString();
          }
        }
      }

      showProgress.value = false;
      update();
    }
    if (kDebugMode) {
      print(response);
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (PrefUtils.getInstance.isUserLogin()) {
      apiCallForGetOrderDetails();
    }
  }
}
