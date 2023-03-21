import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/data/models/address/address_model.dart';
import 'package:linpo_user/app/modules/plus/my_address/address_provider.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/helper/utils/pref_utils.dart';


class MyAddressController extends GetxController {
  final addressProvider = Get.put(AddressProvider());

  AddressModel addressModel = AddressModel();
  Data selectedAddressModel = Data();
  DefaultAddressModel defaultAddressModel = DefaultAddressModel();
  int? selectedId = 0;



  RxBool isDefaultAddress = false.obs;

  RxBool showProgress = false.obs;
  RxBool isSelectedAddress = false.obs;
  RxInt isSelectedAddressIndex = 0.obs;

  getAddressApiCall() async {
    showProgress.value = true;
    // addressModel = AddressModel();
    final response = await addressProvider.getAddress({});
    if (!isNullEmptyOrFalse(response)) {
      addressModel = AddressModel.fromJson(response);
      showProgress.value = false;
    }

    // defaultAddressModel = DefaultAddressModel();
    for (int i = 0; i < (addressModel.data?.length ?? 0); i++) {
      if (addressModel.data![i].isDefaultAddress == 1) {
        defaultAddressModel.id = addressModel.data![i].id;
        defaultAddressModel.addressLabel = addressModel.data![i].addressLabel;
        defaultAddressModel.location = addressModel.data![i].location;
        defaultAddressModel.address = addressModel.data?[i].address ?? "";
        // defaultAddressModel.selectedIndex = defaultAddressModel.id;
        print('-------------${defaultAddressModel.selectedIndex}');
      }
    }

    if (kDebugMode) {
      print(response);
    }
    update(["myaddress"]);
  }



  deleteAddressApiCall({
    String? userAddressId,
  }) async {
    CustomDialogs.getInstance.showProgressDialog();
    final response =
        await addressProvider.deleteAddress({"user_address_id": userAddressId});
    CustomDialogs.getInstance.hideProgressDialog();
    if (!isNullEmptyOrFalse(response)) {
      addressModel.data!
          .removeWhere((element) => element.id.toString() == userAddressId);
      Get.back();
    }
    update(["myaddress"]);

    if (kDebugMode) {
      print(response);
    }
  }

  Future<void> editAddressApiCall({
    int? isDefaultAddress,
    required int indexOfModel,
  }) async {
    CustomDialogs.getInstance.showProgressDialog();
   
    Map<String, dynamic> reqData = {
      "user_address_id": addressModel.data![indexOfModel].id.toString(), //"3",
      "address_label": addressModel.data![indexOfModel].addressLabel.toString(),
      "location": addressModel.data![indexOfModel].location.toString(),
      "address": addressModel.data?[indexOfModel].address ?? "",
      if (!isNullEmptyOrFalse(addressModel.data![indexOfModel].latitude))
        "latitude": addressModel.data![indexOfModel].latitude.toString(),
      if (!isNullEmptyOrFalse(addressModel.data![indexOfModel].longitude))
        "longitude": addressModel.data![indexOfModel].longitude.toString(),
      "is_default_address": isNullEmptyOrFalse(isDefaultAddress) ? 0 : 1,
     
      "service_area_name": addressModel.data![indexOfModel].serviceAreaName
    };
    if (kDebugMode) {
      print(reqData);
    }
    final response = await addressProvider.editAddress(reqData);

    if (kDebugMode) {
      print(response);
    }
    if (!isNullEmptyOrFalse(response)) {
      await getAddressApiCall();
     
      CustomDialogs.getInstance.hideProgressDialog();
    }
    update(["myaddress"]);
  }



  @override
  void onInit() {
    if (PrefUtils.getInstance.isUserLogin()) {
      getAddressApiCall();
    }
    super.onInit();
  }
}
