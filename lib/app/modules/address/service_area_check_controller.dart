import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/data/services/api_service/api_service.dart';
import 'package:linpo_user/app/routes/app_pages.dart';
import 'package:linpo_user/components/common_class.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/helper/utils/constants.dart';
import 'package:linpo_user/helper/utils/pref_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ServiceAreaCheckController extends GetxController {
  TextEditingController directionController = TextEditingController();
  RxBool isMyClearIcon = false.obs;

  TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();

  RxBool isEmailValid = true.obs;
  RxBool isEmailButtonValid = false.obs;

  FocusNode directionFocusNode = FocusNode();
  RxBool isDirectionValid = true.obs;
  RxBool isClearIcon = false.obs;
  List<CustomModel> searchAddressList = [];
  String lat = "";
  String long = "";
  RxBool isDirectionValidForAddress = true.obs;
  RxBool isDirectionButtonValidForAddress = false.obs;
  FocusNode directionFocusNodeForAddress = FocusNode();

  ///cooment
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
        } else {}
      });
    }
    return searchAddressList;
  }

  apiCallForGetLatLong({String? placeId, bool isFromAddAddress = false}) async {
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
        checkServiceAreaApiCall(isFromAddAddress: isFromAddAddress);
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
                  Get.back();
                  directionController.clear();
                  isClearIcon.value = false;
                  // myDirectionController.clear();
                  isMyClearIcon.value = false;
                  update();
                }));
      }
      //}
      update();
    }
  }

  Timer? debounce;
  String query = "";
  int debounceTime = 500;

  onSearchChanged() {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(Duration(milliseconds: debounceTime), () {
      if (directionController.text != "") {
        ///here you perform your search
        apiCallForGetAddressList();
      }
    });
  }

  Future<void> checkServiceAreaApiCall({bool isFromAddAddress = false}) async {
    CustomDialogs.getInstance.showProgressDialog();

    Map<String, dynamic> reqData = {"latitude": lat, "longitude": long};
    final response = await ApiCall().checkServiceArea(reqData);

    if (kDebugMode) {
      print(reqData);
    }

    CustomDialogs.getInstance.hideProgressDialog();
    if (response['data']["is_available"] == 0) {
      isFromAddAddress
          ? showDialog(
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
                    Get.back();
                    directionController.clear();
                    isClearIcon.value = false;
                    // myDirectionController.clear();
                    isMyClearIcon.value = false;
                    update();
                  }))
          : Get.toNamed(Routes.noServiceScreen);
    } else {
      if (!isFromAddAddress) Get.toNamed(Routes.serviceAreaScreen);
    }
    if (response['data']['service_area_name'] != null) {
      // serviceAreaName = response['data']['service_area_name'];
      PrefUtils.getInstance.writeData(
        PrefUtils.getInstance.serviceArea,
        response['data']['service_area_name'],
      );
    }

    if (kDebugMode) {
      print(response);
    }
  }
  Future<void> coverageRequestApiCall({bool isFromAddAddress = true}) async {
    CustomDialogs.getInstance.showProgressDialog();

    Map<String, dynamic> reqData = {
      "latitude": lat,
      "longitude": long,
      "address": directionController.text,
      "email": emailController.text,
    };
    final response = await ApiCall().coveragerequest(reqData);
    print("============>$response");
    if (kDebugMode) {
      print(reqData);
    }

    CustomDialogs.getInstance.hideProgressDialog();
    Get.back();
    showToast(
      msg: response["message"].toString(),
    );

  }
}


class ApiCall extends GetConnect {
  Future<dynamic> getAddressApiCall({String? input}) async {
    Response? response;
    // final request = "https://maps.googleapis.com/maps/api/place/autocomplete/json?components=country:cl|country:in&types=address&input=$input&key=$placeKey";
    final request =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?components=country:cl&types=address&input=$input&key=$placeKey";
    // final request =
    //     "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&sensor=false&types=(regions)&key=$placeKey&components=country:CL";
    // final request =
    //     'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$placeKey';
    response = await get(request);

    if (response.statusCode == 200) {
      if (response.body['status'] == 'OK') {
        return response.body;
      }
      if (response.body['status'] == 'ZERO_RESULTS') {
        return false;
      }
    } else {
      return false;
    }
  }

  Future apiCallForLatLong({String? placeId}) async {
    Response? response;

    final request =
        "https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=$placeKey";
    response = await get(request);

    if (response.statusCode == 200) {
      if (response.body['status'] == 'OK') {
        if (kDebugMode) {
          print(response.body['result']['geometry']['location']['lat']);
        }
        if (kDebugMode) {
          print(response.body['result']['geometry']['location']['lng']);
        }
        return response.body;
      }
      if (response.body['status'] == 'ZERO_RESULTS') {
        return false;
      }
    } else {
      return false;
    }
    if (kDebugMode) {
      print("LatLong: ${response.body}");
    }
  }

  checkServiceArea(reqData) async {
    final response = await ApiService.postRequest(
      ApiConstants.checkServiceAreaUrl,
      body: reqData,
    );
    return response;
  }
  coveragerequest(reqData) async {
    final response = await ApiService.postRequest(
      ApiConstants.checkServiceAreaUrl,
      body: reqData,
    );
    return response;
  }
}

class CustomModel {
  String? description;
  String? placeId;
  CustomModel({this.description, this.placeId});
}
showToast({String? msg = "", Color? color}) {
  return Get.snackbar(
    "Limpo",
    msg!,
    backgroundColor: Colors.green[100],
    snackPosition: SnackPosition.TOP,
  );

}