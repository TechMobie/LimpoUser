import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/data/models/services/product_services_model.dart';
import 'package:linpo_user/app/modules/services/services_provider.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/helper/utils/constants.dart';

class ServicesController extends GetxController {
  ServicesProvider serviceProvider = ServicesProvider();
  // TypesOfServicesModel typeOfServices = TypesOfServicesModel();
  ProductsServicesModel productsServicesModel = ProductsServicesModel();
  // List<TypesOfServicesModel> categoriesList = [];
  RxInt selectedCategories = 0.obs;
  RxInt counter = 0.obs;
  double totalPrice = 0;
  RxBool showProgress = false.obs;

  // double totalQuantity = 0;
  // final myWashingMachineController =
  //     Get.put<MyWashingMachineController>(MyWashingMachineController());
  Future getProductApiCall() async {
    showProgress.value = true;

    final response = await serviceProvider.getProduct({});
    if (kDebugMode) {
      print(response);
    }
    totalPrice = 0;
    totalQuentity.value = 0;
    if (!isNullEmptyOrFalse(response)) {
      productsServicesModel = ProductsServicesModel.fromJson(response);
      for (int i = 0; i < productsServicesModel.data!.length; i++) {
        for (int j = 0;
            j < productsServicesModel.data![i].products!.length;
            j++) {
          if (productsServicesModel.data![i].products![j].quantity != 0) {
            totalQuentity.value +=
                productsServicesModel.data![i].products![j].quantity!;
            if (kDebugMode) {
              print("quantity${totalQuentity.value}");
            }
            totalPrice = (totalPrice +
                (productsServicesModel.data![i].products![j].quantity!) *
                    int.parse(productsServicesModel.data![i].products![j].price
                        .toString()));
            if (kDebugMode) {
              print(totalPrice);
            }
          }
        }
      }
      showProgress.value = false;
    }
    if (kDebugMode) {
      print(response);
    }
    update();
  }

  addToCartApiCall(
      {int? typeOfServiceId, int? productId, int? quantity}) async {
        
    CustomDialogs.getInstance.showProgressDialog();
    Map<String, dynamic> reqData = {
      "type_of_service_id": typeOfServiceId,
      "product_id": productId,
      "quantity": quantity
    };
    final response = await serviceProvider.addToCartOfServices(reqData);
    CustomDialogs.getInstance.hideProgressDialog();

    if (kDebugMode) {
      print(response);
    }
  }

  @override
  void onInit() {
    getProductApiCall();

    super.onInit();
  }
}
