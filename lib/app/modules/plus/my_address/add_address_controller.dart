import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/data/models/address/address_model.dart';
import 'package:linpo_user/app/modules/address/service_area_check_controller.dart';
import 'package:linpo_user/app/modules/plus/my_address/address_provider.dart';
import 'package:linpo_user/app/modules/plus/my_address/my_address_controller.dart';
import 'package:linpo_user/components/common_class.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';


class AddAddressController extends GetxController {
  final addressProvider = Get.put(AddressProvider());
  final MyAddressController myAddressController =
      Get.find<MyAddressController>();
  TextEditingController addressLabelController = TextEditingController();
  FocusNode addressLabelFocusNode = FocusNode();

  TextEditingController detailAddressController = TextEditingController();
  FocusNode detailAddressFocusNode = FocusNode();
  TextEditingController myDirectionController = TextEditingController();
  FocusNode mydirectionFocusNode = FocusNode();
  RxBool isDirectionValid = true.obs;
  RxBool isDirectionButtonValid = false.obs;
  RxBool isAddressLabelButtonValid = false.obs;
  RxBool isDetailAddressButtonValid = false.obs;
  RxBool isAddressLabelValid = true.obs;
  RxBool isDetailAddressValid = true.obs;
  String serviceName = '';
  addAddressApiCall(
      {bool? isDefaultAddress,
      required String lat,
      required String long}) async {
    CustomDialogs.getInstance.showProgressDialog();

    Map<String, dynamic> req = {
      "address_label": addressLabelController.text.trimRight(),
      "location": myDirectionController.text.trimRight(), //"Surat",
      "address": detailAddressController.text.trimRight(),
      "latitude": lat,
      "longitude": long,
      "is_default_address": isDefaultAddress! ? 1 : 0,
      "service_area_name": serviceName
    };
    final response = await addressProvider.addAddress(req);
    CustomDialogs.getInstance.hideProgressDialog();
    if (!isNullEmptyOrFalse(response)) {
      if (kDebugMode) {
        print(response);
      }

      myAddressController.addressModel.data
          ?.insert(0, (Data.fromJson(response['data'])));
      Get.back();
      await myAddressController.getAddressApiCall();
    }
    update(["myaddress"]);

    if (kDebugMode) {
      print(response);
    }
  }

  Future<void> editAddressApiCall(
      {String? userAddressId,
      int? isDefaultAddress,
      required String lat,
      required String long}) async {
    CustomDialogs.getInstance.showProgressDialog();
    // if (kDebugMode) {
    //   print(
    //     "Service area :=-" +
    //         PrefUtils.getInstance.readData(
    //           PrefUtils.getInstance.serviceArea,
    //         ),
    //   );
    // }
    Map<String, dynamic> reqData = {
      "user_address_id": userAddressId, //"3",
      "address_label": addressLabelController.text.trimRight(),
      "location": myDirectionController.text.trimRight(),
      "address": detailAddressController.text.trimRight(),
      if (!isNullEmptyOrFalse(lat)) "latitude": lat,
      if (!isNullEmptyOrFalse(long)) "longitude": long,
      "is_default_address": isNullEmptyOrFalse(isDefaultAddress) ? 0 : 1,
      "service_area_name":serviceName
    };
    if (kDebugMode) {
      print(reqData);
    }
    final response = await addressProvider.editAddress(reqData);

    if (kDebugMode) {
       print(response);
    }
    if (!isNullEmptyOrFalse(response)) {
      await myAddressController.getAddressApiCall();
      if (kDebugMode) {
        print(lat);
      }
      if (kDebugMode) {
        print(long);
      }
      CustomDialogs.getInstance.hideProgressDialog();
    }
    update(["myaddress"]);
  }

  RxBool isClearIcon = false.obs;
  List<CustomModel> searchAddressList = [];

  String lat = "";
  String long = "";
  RxBool isMyClearIcon = false.obs;
  // TextEditingController myDirectionController = TextEditingController();
  // FocusNode mydirectionFocusNode = FocusNode();
  apiCallForGetAddressList(
      {TextEditingController? textEditingController}) async {
    if (textEditingController!.text.isNotEmpty) {
      await ApiCall()
          .getAddressApiCall(
        input: textEditingController.text,
      )
          .then((value) {
        searchAddressList.clear();
        if (value != false) {
          if (kDebugMode) {
            print(value);
          }
          for (int i = 0; i < value["predictions"].length; i++) {
            searchAddressList.add(CustomModel(
                placeId: value["predictions"][i]["place_id"].toString(),
                description:
                    value["predictions"][i]["description"].toString()));
          }
          if (kDebugMode) {
            print(value["predictions"][1]["place_id"].toString());
          }

          update();
        }
      });
    }
    return searchAddressList;
  }

  apiCallForGetLatLong({
    String? placeId,
  }) async {
    CustomDialogs.getInstance.showProgressDialog();
    lat = "";
    long = "";
    String formattedAddress = "";
    String vicinity = "";
    String streetNumber = "";
    final response = await ApiCall().apiCallForLatLong(placeId: placeId);
    if (kDebugMode) {
      print(response);
    }
    CustomDialogs.getInstance.hideProgressDialog();
    if (!isNullEmptyOrFalse(response)) {
      lat = response['result']['geometry']['location']['lat'].toString();
      long = response['result']['geometry']['location']['lng'].toString();
      formattedAddress = response['result']['formatted_address'].toString();
      vicinity = response['result']['vicinity'].toString();
      if (kDebugMode) {
        print('Formatted Address $formattedAddress');
      }
      if (kDebugMode) {
        print('Vicinity $vicinity');
      }
      for (var address in response['result']['address_components']) {
        if (address["types"].first == "street_number") {
          streetNumber = address['long_name'].toString();
        }
      }

      if (formattedAddress.isNotEmpty &&
          vicinity.isNotEmpty &&
          streetNumber.isNotEmpty) {
        checkServiceAreaApiCall();
      } else {
        showDialog(
            context: Get.context!,
            builder: (_) => Alertdialog(
                isFullButton: true,
                titleWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(Get.context!)!.incompleteAddress,
                      style: const TextStyle().normal18,
                    )
                  ],
                ),
                contentText:
                    AppLocalizations.of(Get.context!)!.pleaseSelectAnAddress,
                contentTextStyle: const TextStyle()
                    .normal16
                    .textColor(ColorSchema.grey54Color),
                actionWidget: Text(
                  AppLocalizations.of(Get.context!)!.returnCaps,
                  style: const TextStyle()
                      .medium16
                      .textColor(ColorSchema.whiteColor),
                ),
                onTap: () {
                  isClearIcon.value = false;
                  myDirectionController.clear();
                  isDirectionButtonValid.value = false;
                  isDirectionValid.value = true;
                  isMyClearIcon.value = false;
                  Get.back();
                  update();
                }));
      }
      //}
      update();
    }
  }

  Future<void> checkServiceAreaApiCall() async {
    CustomDialogs.getInstance.showProgressDialog();

    Map<String, dynamic> reqData = {"latitude": lat, "longitude": long};
    final response = await ApiCall().checkServiceArea(reqData);

    if (kDebugMode) {
      print(reqData);
    }

    CustomDialogs.getInstance.hideProgressDialog();
    if (response['data']["is_available"] == 0) {
      showDialog(
          context: Get.context!,
          builder: (_) => Alertdialog(
              isFullButton: true,
              titleWidget: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(Get.context!)!.withoutSignal,
                    style: const TextStyle().normal18,
                  )
                ],
              ),
              contentText:
                  AppLocalizations.of(Get.context!)!.sorryNotAddressYet,
              contentTextStyle:
                  const TextStyle().normal16.textColor(ColorSchema.grey54Color),
              actionWidget: Text(
                AppLocalizations.of(Get.context!)!.returnCaps,
                style: const TextStyle()
                    .medium16
                    .textColor(ColorSchema.whiteColor),
              ),
              onTap: () {
                isDirectionButtonValid.value = false;
                isDirectionValid.value = true;
                isClearIcon.value = false;
                myDirectionController.clear();
                isMyClearIcon.value = false;
                Get.back();
                update();
              }));
    }
    if (response['data']['service_area_name'] != null) {
      // serviceAreaName = response['data']['service_area_name'];
      // PrefUtils.getInstance.writeData(
      //   PrefUtils.getInstance.serviceArea,
      //   response['data']['service_area_name'],
      // );
      serviceName = response['data']['service_area_name'];
      print(serviceName);
    }

    if (kDebugMode) {
      print(response);
    }
  }
}
